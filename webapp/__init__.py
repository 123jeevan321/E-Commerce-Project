from .databaseConfig import database_connector

database_connector()

import secrets
from datetime import date
from flask import Flask, render_template, request, url_for, redirect, session, flash ,jsonify
from .dbaccess import *
from flask_session import Session
import os


app = Flask(__name__)
app.secret_key = secrets.token_hex(16)
sess = Session()

ADMIN_USERNAME = "admin"
ADMIN_PASSWORD = "password123"

@app.route("/")
def home():
    signedin = False
    username = None
    if "userid" in session:
        signedin = True
        username = session.get("username")
    return render_template("home.html", signedin=signedin, username=username)

@app.route("/signup/", methods=["POST", "GET"])
def signup():
    if request.method == "POST":
        data = request.form
        ok = add_user(data)
        if ok:
            session["user_authenticated"] = True
            return render_template("home.html")
        else:
            flash("Username already taken. Please choose another username.", "error")
        return render_template("signup.html", ok=ok)
    return render_template("signup.html", ok=True)

@app.route("/login/", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        data = request.form
        userdat = auth_user(data)
        if userdat:
            session["user_authenticated"] = True
            session["userid"] = userdat[0]
            session["username"] = userdat[1]
            session['signedin'] = True
            return redirect(url_for('home'))
        return render_template("login.html", err=True)
    return render_template("login.html", err=False)

@app.route("/logout/")
def logout():
    if 'userid' in session:
        session.pop('userid')
    if 'username' in session:
        session.pop('username')
    session['signedin'] = False
    return redirect(url_for('home'))

@app.route('/products')
def products():
    product = get_product_info()
    if product:
        return render_template('products.html', product=product)
    return render_template('products.html')

@app.route('/electronics')
def get_electronics():
    category_name = "ELECTRONIC PRODUCTS"
    electronics = get_categories("Electronics")
    return render_template('main_categories.html', products=electronics, category_name=category_name)

@app.route('/toys')
def get_toys():
    category_name = "TOY PRODUCTS"
    toys = get_categories("Toys")
    return render_template('main_categories.html', products=toys, category_name=category_name)

@app.route('/products/<product_id>', methods=['GET'])
def get_products(product_id):
    varients = get_products_from_database(product_id)
    return render_template('product_detail.html', products=varients)

@app.route("/product/<id>/")
def view_product(id):
    tup = get_single_product_info(id)
    print(tup)
    return render_template('product_detail.html', product=tup)


@app.route('/varients/<product_id>', methods=['GET'])
def get_varient(product_id):
    tup = get_varient_info(product_id)
    print(tup)
    variant_id = (tup[-1][-1])
    print(variant_id)
    stock_count = get_stock_count(variant_id)
    print(stock_count, "is the stock count")
    signedin = False
    if "userid" in session:
        signedin = True
    return render_template('variants.html', variants=tup, signedin=signedin, stock_count=stock_count)


@app.route("/cart/", methods=["POST", "GET"])
def cart():
    signedin = session['signedin']
    if signedin is True:
        username = session['username']
        cart = get_cart(session['userid'])
        return render_template('cart.html', cart=cart, signedin=signedin, username=username)
    else:
        signedin = False
        session_cart = session.get('cart', {})
        variant_ids_string = list(session_cart.keys())
        variant_ids = [int(i) for i in variant_ids_string]
        variant_details = get_guest_cart(variant_ids)
        for i in range(len(variant_details)):
            variant_details[i] = variant_details[i] + (variant_ids[i],)
        return render_template('cart.html', guest_cart=variant_details, signedin=False, session_cart=session_cart)


@app.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    variant_id = request.form.get('variant_id')
    quantity = int(request.form.get('quantity'))
    try:
        username = session['username']
        if username is not None:
            print('hi')
            user_id = session['userid']
            update_cart(user_id, variant_id, quantity)
            return redirect(url_for('cart'))
    except KeyError:
        if 'cart' not in session:
            session['cart'] = {}
        cart = session['cart']
        if variant_id in cart:
            cart[variant_id] += quantity
        else:
            cart[variant_id] = quantity
        session.modified = True
        return redirect(url_for('cart'))


@app.route('/checkout')
def checkout():
    is_logged = session['signedin']
    if is_logged is True:
        user_id = session['userid']
        items = get_cart(user_id)
        total_price = sum([(tup[0] * tup[2]) for tup in items])
        print(total_price)
        return render_template('checkout.html', total_price=total_price)
    else:
        flash('You are going to checkout as a guest. Some features may not be not available')
        return render_template('checkout.html')


@app.route('/checkout_successful', methods=['POST'])
def checkout_successful():
    if request.method == 'POST':
        full_name = request.form.get('firstname')
        email = request.form.get('email')
        city = request.form.get('city')
        signedin = session['signedin']
        order_id = gen_orderID()
        current_date = date.today()
        formatted_date = current_date.strftime('%Y-%m-%d')
        if signedin:
            user_id = session['userid']
            order_table_details = [order_id, formatted_date, 'Express', 'visa', user_id]
            update_order_table(order_table_details)
            cart = get_cart(session['userid'])
            order_item_ids = []
            for item in cart:
                new_ID = gen_order_item_ID()
                order_item_ids.append(new_ID)
                variant_Id = item[5]
                quantity = item[0]
                price = item[2]
                temp = []
                temp.append((new_ID, order_id, variant_Id, quantity, price))
                stock_count = get_stock_count(variant_Id)
                destination_city = city
                delivary_module = [stock_count, destination_city, new_ID]
                update_order_items(temp, signedin, user_id=user_id)
                update_delivary_module(delivary_module)
            names = get_details_for_delivery_module(order_item_ids)
            return (render_template('checkout_succesful.html', names=names))

        if not signedin:
            user_id = 0
            order_table_details = [order_id, formatted_date, 'Express', 'visa', user_id]
            update_order_table(order_table_details)
            session_cart = session.get('cart', {})
            variant_ids_string = list(session_cart.keys())
            variant_ids = [int(i) for i in variant_ids_string]
            guest_cart = get_guest_cart(variant_ids)
            order_item_ids = []
            for item in guest_cart:
                new_ID = gen_order_item_ID()
                order_item_ids.append(new_ID)
                order_item_ids.append(new_ID)
                variant_Id = item[4]
                quantity = session_cart[str(variant_Id)]
                price = item[2]
                temp = []
                temp.append((new_ID, order_id, variant_Id, quantity, price))
                stock_count = get_stock_count(variant_Id)
                destination_city = city
                delivary_module = [stock_count, destination_city, new_ID]
                update_order_items(temp, signedin, user_id=user_id)
                update_delivary_module(delivary_module)
            session['cart'].clear()
            return render_template('login.html', full_name=full_name, email=email)


@app.route('/searching', methods=['GET', 'POST'])
def searching():
    if request.method == 'POST':
        search_query = request.form.get('search_query')
        return redirect(url_for('search_results', query=search_query))
    else:
        return render_template('search.html')

@app.route('/search', methods=['GET'])
def search_products():
    search_query = request.args.get('query')
    products = search_product(search_query)
    return render_template('search_results.html', products=products)

@app.route('/myorders', methods=['GET'])
def myorders():
    # Check if the user is signed in
    signedin = session.get('signedin', False)
    if signedin:
        print("User is signed in")
        user_id = session.get('userid')
        print("User is signed in")# Assuming 'user_id' is the key for user ID in the session
        print("Session data:", session)
        if user_id is not None:
            print("User ID found in session:", user_id)
            print("Session data:", session)
            order_details = get_order_details(user_id)
            username = session.get('username', '')
            return render_template('my_orders.html', order_details=order_details, signedin=signedin,username=username)
        else:
            # print("User ID not found in session")
            flash('User ID not found in session', 'error')
            return redirect(url_for('login'))
    else:
        flash('User is not signed in', 'error')
        return redirect(url_for('login'))



@app.route('/admin', methods=['GET', 'POST'])
def admin():
        return render_template('admin_login.html')


@app.route('/admin_login', methods=['GET', 'POST'])
def admin_login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if username == ADMIN_USERNAME and password == ADMIN_PASSWORD:
            session['is_admin'] = True  # Set session variable to indicate admin login
            return redirect(url_for('admin_dashboard'))  # Redirect to admin dashboard upon successful login
        else:
            error = 'Invalid Credentials. Please try again.'
    return render_template('admin_login.html', error=error)

@app.route('/admin_dashboard')
def admin_dashboard():
    if session.get('is_admin'):
        return render_template('admin_dashboard.html')
    else:
        return redirect(url_for('admin_login'))

@app.route('/all_users_page')
def all_users_page():
    # Add logic to fetch and display all users here

    users = get_all_users()
    print(users)
    return render_template('all_users.html', users=users)



@app.route('/all_orders_page')
def all_orders_page():
    # Add logic to fetch and combine data from multiple tables
    orders = get_all_orders()  # Implement this function to fetch data from multiple tables

    # Pass the combined orders data to the template for rendering
    return render_template('all_orders.html', orders=orders)



app.config['SECRET_KEY'] = os.urandom(17)
app.config['SESSION_TYPE'] = 'filesystem'
app.config['TEMPLATES_AUTO_RELOAD'] = True
sess.init_app(app)
