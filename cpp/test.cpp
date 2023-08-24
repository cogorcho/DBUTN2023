#include <iostream>
#include <stdlib.h>
///usr/share/doc/libmysqlcppconn-dev
#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>

using namespace std;

int main(void) {
    cout << endl;
    cout << "Running 'SELECT 'Hello World!' AS _message...'" << endl;

    try {
        sql::Driver *driver;
        sql::Connection *con;
        sql::Statement *stmt;
        sql::ResultSet *res;

        /* Create a connection */
        driver = get_driver_instance();
        con = driver->connect("tcp://127.0.0.1:3306","root","Soler225");
        con->setSchema("dbutn");

        stmt = con->createStatement();
        //res = stmt->executeQuery("Select 'Hello World!' AS _message");
        res = stmt->executeQuery("Select table_name as _message from information_schema.tables");

        while(res->next()) {
            cout << "\t...MYSQL replies: ";
            /* Access column data by alias or column name*/
            cout << res->getString("_message") << endl;
            cout << "\t...MYSQL says it again: ";
            /* Access column data by numeric offset, 1 is the first column */
            cout << res->getString(1) << endl;
        }

        delete res;
        delete stmt;
        delete con;

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