import mysql.connector
from .databaseConfig import get_db_config_data
from werkzeug.security import generate_password_hash,check_password_hash

config = get_db_config_data()


def get_mysql_connection():
    return mysql.connector.connect(**config)


def gen_custID():
    conn = get_mysql_connection()
    cur = conn.cursor()
    cur.execute("SELECT user_id FROM registered_user ORDER BY user_id DESC LIMIT 1")
    res = cur.fetchall()
    conn.close()
    if res:
        last_id = res[0][0]

        return last_id + 1
    else:

        return 0


def add_user(data):
    conn = get_mysql_connection()
    cur = conn.cursor()
    username = data["username"]

    cur.execute("SELECT * FROM registered_user WHERE username=%s", (username,))
    result = cur.fetchall()

    if len(result) != 0:
        return False
    customer_id = gen_custID()
    tup = (customer_id, data["email"], generate_password_hash(data["password"], method='pbkdf2:sha256'), data["username"],)

    cur.execute("INSERT INTO registered_user (user_id,email, password, username) VALUES (%s, %s, %s, %s)", tup)

    conn.commit()
    conn.close()
    return True

def auth_user(data):
    conn = get_mysql_connection()
    cur = conn.cursor()

    username = data["username"]
    password = data["password"]


    cur.execute("SELECT user_id,username,password FROM registered_user WHERE username=%s", (username,))

    result = cur.fetchall()
    print("hello mofossssssssssssssssssssssssssss", result[0][2])
    conn.close()
    if not check_password_hash(result[0][2], password):
        return False
    return result[0]

def get_categories(category):
    conn = get_mysql_connection()
    cur = conn.cursor()

    query = """
            SELECT Category.category_name, Category.category_image,Category.category_id
            FROM Category
            WHERE Category.parent_category_id = (
                SELECT category_id FROM Category WHERE category_name = %s
            )
        """
    cur.execute(query, (category,))
    results = cur.fetchall()
    return results

def get_products_from_database(id):

    conn = get_mysql_connection()
    cur = conn.cursor()


    query = "SELECT product.title,product.description,product.weight,product.product_image,product.product_id FROM product WHERE category_id = %s"
    cur.execute(query, (id,))

    results = cur.fetchall()
    return results


def get_product_info():
    conn = get_mysql_connection()
    cur = conn.cursor()

    cur.execute("SELECT * FROM product")
    products = cur.fetchall()
    return products

def get_single_product_info(product_id):
    try:
        conn = get_mysql_connection()
        with conn.cursor() as cur:

            cur.execute("SELECT * FROM product WHERE id = %s", (product_id,))
            details = cur.fetchone()
        return details
    except Exception as e:

        return None

def get_varient_info(product_id):
        conn = get_mysql_connection()
        with conn.cursor() as cur:
            cur.execute(
                "SELECT variant.name,variant.price,variant.custom_attrbutes,variant.variant_image,variant.variant_id FROM variant WHERE product_id = %s",
                (product_id,))
            result = cur.fetchall()

        return result

def get_stock_count(variant_id):
    conn = get_mysql_connection()


    cur = conn.cursor()
    query = "SELECT stock_count FROM inventory WHERE variant_id = %s"

    cur.execute(query, (variant_id,))

    result = cur.fetchone()

    print(result)

    if result:
        stock_count = result[0]
        return stock_count
    else:
        return None


def update_cart(user_id, variant_id, quantity):
    conn = get_mysql_connection()
    cur = conn.cursor()
    print("hello world")
    # Define the SQL statement using the INSERT ... ON DUPLICATE KEY UPDATE syntax
    # Define the SQL statement with an alias for VALUES
    query = """
        INSERT INTO cart_item (user_id, variant_id, quantity)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE quantity = cart_item.quantity
        """
    # Execute the SQL statement with the provided user_id, variant_id, and quantity
    cur.execute(query, (user_id, variant_id, quantity))

    conn.commit()
    conn.close()
    return

def get_cart(custID):
    conn = get_mysql_connection()
    cur = conn.cursor()

    sql_query = """
    SELECT
        ci.quantity AS quantity,
        v.name AS name,
        v.price AS price,
        v.variant_image AS variant_image,
        p.title AS title,
        v.variant_id as variant_id
    FROM
        cart_item AS ci
    JOIN
        variant AS v ON ci.variant_id = v.variant_id
    JOIN
        product AS p ON v.product_id = p.product_id
    WHERE
        ci.user_id = %s
    """
    cur.execute(sql_query, (custID,))
    result = cur.fetchall()
    conn.close()
    print(result)

    return result


# this function will fetch variant details for a guest's cart
def get_guest_cart(variant_ids):
    conn = get_mysql_connection()
    cur = conn.cursor()
    result = []
    query = """
    SELECT p.title, v.name, v.price, v.variant_image,v.variant_id
    FROM product AS p
    JOIN variant AS v ON p.product_id = v.product_id
    WHERE 
        v.variant_id = %s
    """
    for variant_id in variant_ids:
        # Execute the query for each variant_id
        cur.execute(query, (variant_id,))
        rows = cur.fetchall()
        for row in rows:
            result.append(row)

    return result



def gen_orderID():
    conn = get_mysql_connection()
    cur = conn.cursor()
    cur.execute("SELECT order_id FROM order_item ORDER BY order_id DESC LIMIT 1")
    res = cur.fetchall()
    conn.close()
    if res:
        last_id = res[0][0]
        return last_id + 1
    else:
        return 0


def update_order_table(order_table_details):
    conn = get_mysql_connection()
    cursor = conn.cursor()
    try:
        order_id, date, delivery_method, payment_method, user_id = order_table_details
        insert_query = "INSERT INTO orders (order_id, date, delivery_method, payment_method, user_id) VALUES (%s, %s, %s, %s, %s)"
        cursor.execute(insert_query, (order_id, date, delivery_method, payment_method, user_id))
        conn.commit()

    except mysql.connector.Error as err:
        print("Error: {}".format(err))


def gen_order_item_ID():
    conn = get_mysql_connection()
    cur = conn.cursor()
    cur.execute("SELECT order_item_id FROM order_item ORDER BY order_item_id DESC LIMIT 1")
    res = cur.fetchall()
    conn.close()
    if res:
        last_id = res[0][0]
        return last_id + 1
    else:
        return 0


def update_order_items(order_items, is_signedin, user_id):
    conn = get_mysql_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("START TRANSACTION")

        if is_signedin:
            order_item_id, order_id, variant_id, quantity, price = order_items[0]
            insert_query = "INSERT INTO order_item (order_item_id, order_id, variant_id, quantity, price) VALUES (%s, %s, %s, %s, %s)"
            cursor.execute(insert_query, (order_item_id, order_id, variant_id, quantity, price))
            delete_query = "DELETE FROM cart_item WHERE user_id = %s"
            cursor.execute(delete_query, (user_id,))
            update_query = "UPDATE inventory SET stock_count = stock_count - %s WHERE variant_id = %s"
            cursor.execute(update_query, (quantity, variant_id))
        cursor.execute("COMMIT")

    except Exception as e:
        cursor.execute("ROLLBACK")
        raise e
    finally:
        conn.close()


def update_delivary_module(module):
    conn = get_mysql_connection()
    cur = conn.cursor()
    main_cities = ['Colombo', 'Panadura', 'Galle', 'Kandy']
    new_id = gen_delivery_ID()
    tup = new_id, module[2], module[1]

    if module[0] > 0:
        if (module[1] in main_cities):
            tup = tup + (5,)
            cur.execute(
                "INSERT INTO delivery_module (delivery_module_id, order_item_id, destination_city, estimated_days) VALUES (%s, %s, %s, %s)",
                tup)
        else:
            tup = tup + (7,)
            cur.execute(
                "INSERT INTO delivery_module (delivery_module_id, order_item_id, destination_city, estimated_days) VALUES (%s, %s, %s, %s)",
                tup)

    else:
        if (module[1] in main_cities):
            tup = tup + (8,)
            cur.execute(
                "INSERT INTO delivery_module (delivery_module_id, order_item_id, destination_city, estimated_days) VALUES (%s, %s, %s, %s)",
                tup)
        else:
            tup = tup + (10,)
            cur.execute(
                "INSERT INTO delivery_module (delivery_module_id, order_item_id, destination_city, estimated_days) VALUES (%s, %s, %s, %s)",
                tup)

    conn.commit()

def gen_delivery_ID():
    conn = get_mysql_connection()
    cur = conn.cursor()
    cur.execute("SELECT delivery_module_id FROM delivery_module ORDER BY order_item_id DESC LIMIT 1")
    res = cur.fetchall()
    conn.close()
    if res:
        last_id = res[0][0]
        return last_id + 1
    else:
        return 0

def get_details_for_delivery_module(order_item_ids):
    conn = get_mysql_connection()
    cursor = conn.cursor()
    variant_info = []

    try:
        for order_item_id in order_item_ids:
            query = """
            SELECT variant.name, delivery_module.estimated_days
            FROM order_item
            INNER JOIN variant ON order_item.variant_id = variant.variant_id
            LEFT JOIN delivery_module ON order_item.order_item_id = delivery_module.order_item_id
            WHERE order_item.order_item_id = %s
            """
            cursor.execute(query, (order_item_id,))
            result = cursor.fetchone()
            if result:
                variant_info.append(result)
        print(variant_info)
    except Exception as e:
        print("Error:", e)
    return variant_info

def search_product(search_query):
    conn = get_mysql_connection()
    cur = conn.cursor()
    sql_query = "SELECT * FROM product WHERE title LIKE %s"
    cur.execute(sql_query, ("%" + search_query + "%",))
    matching_products = cur.fetchall()
    return matching_products


def get_order_details(user_id):
    conn = get_mysql_connection()
    cur = conn.cursor()

    sql_query = """
    SELECT
        DATE_FORMAT(o.date, '%d-%m-%Y') AS formatted_date,
        o.order_id,
        o.delivery_method,
        o.user_id,
        ru.username,  -- Include the username from the registered_user table
        d.destination_city,
        d.estimated_days,
        oi.quantity,
        oi.price,
        p.title AS product_name,
        v.variant_image
    FROM
        orders AS o
    JOIN
        order_item AS oi ON o.order_id = oi.order_id
    JOIN
        delivery_module AS d ON oi.order_item_id = d.order_item_id
    JOIN
        variant AS v ON oi.variant_id = v.variant_id
    JOIN
        product AS p ON v.product_id = p.product_id
    JOIN
        registered_user AS ru ON o.user_id = ru.user_id  -- Join with the registered_user table to get the username
    WHERE
        o.user_id = %s
    """
    cur.execute(sql_query, (user_id,))
    order_details = cur.fetchall()
    conn.close()
    return order_details

def get_all_users():
    # Establish a connection to the database
    connection = get_mysql_connection()
    cursor = connection.cursor()

    # Fetch all users from the database
    cursor.execute("SELECT * FROM registered_user")
    users = cursor.fetchall()

    # Close cursor and connection
    cursor.close()
    connection.close()

    return users

def get_all_orders():
    connection = get_mysql_connection()
    cursor = connection.cursor(dictionary=True)

    # Execute SQL query to retrieve data from multiple tables using JOIN operations
    query = """
        SELECT 
            o.order_id, o.date, o.payment_method, o.delivery_method,
            oi.variant_id, oi.quantity, oi.price,
            dm.destination_city, dm.estimated_days,
            ru.username,
            v.variant_image
        FROM 
            orders o
        INNER JOIN 
            order_item oi ON o.order_id = oi.order_id
        INNER JOIN 
            delivery_module dm ON oi.order_item_id = dm.order_item_id
        INNER JOIN
            registered_user ru ON o.user_id = ru.user_id
        INNER JOIN
            variant v ON oi.variant_id = v.variant_id
    """

    cursor.execute(query)
    orders = cursor.fetchall()

    cursor.close()
    connection.close()

    return orders