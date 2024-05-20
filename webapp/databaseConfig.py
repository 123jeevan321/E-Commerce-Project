import os
import sys
from colorama import init, Fore, Style
import mysql.connector
from mysql.connector import errorcode
# from dotenv import load_dotenv
from werkzeug.security import generate_password_hash,check_password_hash


def get_db_config_data():
    _config = {
        "host": os.getenv("HOST") if os.getenv("HOST") else "localhost",
        "user": os.getenv("USER") if os.getenv("USER") else "root",
        "password": os.getenv("PASSWORD"),
        "database": os.getenv("DATABASE") if os.getenv("DATABASE") else "ecommerce",
        "raise_on_warnings": True
        # Throws an exception when there is an error with other provided parameters such as when database does not
        # exist.
    }
    return _config


def database_connector():
    # Defining the connection parameters in a config dictionary
    _config = get_db_config_data()

    try:
        connection = mysql.connector.connect(**_config)
        print(Style.BRIGHT + Fore.GREEN + f'Successfully Connected to the MYSQL Database "{_config["database"]}".')
        connection.close()
        return _config
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_BAD_DB_ERROR:
            print(Style.BRIGHT + Fore.YELLOW + "Database not Found! Generating the initial database")
            #generate_database(_config)
            return _config
        else:
            print(Style.BRIGHT + Fore.RED + f"Database Server Connection Failed!\nError: {err}")
            sys.exit()
