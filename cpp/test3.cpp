#include <iostream>
#include <stdlib.h>
#include <string>
#include <vector>
#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <Tabla.h>

string SQL1 = "Select table_name as _message from information_schema.tables where table_schema = 'employees'";


int main(void) {
    try {
        sql::Driver *driver;
        sql::Connection *con;
        sql::Statement *stmt;
        sql::ResultSet *res;
        vector<Tabla> tablas;

        /* Create a connection */
        driver = get_driver_instance();
        con = driver->connect("tcp://127.0.0.1:3306","db2023","db2023");
        con->setSchema("employees");

        stmt = con->createStatement();
        res = stmt->executeQuery(SQL1.c_str());

        while(res->next()) {
            Tabla t(con, res->getString(1));
            t.genClass();
            t.genDelete();
            tablas.push_back(t);
        }

        delete res;
        delete stmt;
        delete con;
        cout << "Tablas: " << tablas.size() << endl;

    } catch (sql::SQLException &e) {
        cout << "# ERR: SQLException in " << __FILE__;
        cout << "(" << __FUNCTION__ << ") on line " << __LINE__ << endl;
        cout << "# ERR: " << e.what();
        cout << " (MySQL error code: " << e.getErrorCode();
        cout << ", SQLSTATE: " << e.getSQLState() << " )" << endl;
    }

    cout << endl;
    return EXIT_SUCCESS;
}