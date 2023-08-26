#include <iostream>
#include <stdlib.h>
#include <string>
#include <vector>
#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>

using namespace std;
string SQL1 = "Select table_name as _message from information_schema.tables where table_schema = 'dbutn'";
string SQL2 = "Select ordinal_position, column_name, data_type, concat('',ifnull(character_maximum_length,0)), ifnull(column_key,'NO') from information_schema.columns where table_schema = 'dbutn' and table_name = 'TNAME' order by ordinal_position";
string REPLACE = "TNAME";

class Columna {
    public:
        int orden;
        string nombre;
        string tipo;
        int tamanio;
        string texto;
        int isPk;

        void print() {
            cout << orden << ", " << nombre << ", " << tipo << ", " << tamanio 
                << ", " << texto << ", " << isPk << endl; 
        }

        string paramsInsert() {
            string pains = "";
            if (orden == 1) {
                if (isPk == 1) {
                    pains += "\t " + nombre + " " + texto + " OUT" + '\n'; 
                }
                else {
                    pains += "\t " + nombre + " " + texto + '\n'; 
                }
            }
            else {
                if (isPk == 1) {
                    pains += "\t," + nombre + " " + texto + " OUT" + '\n'; 
                }
                else {
                    pains += "\t," + nombre + " " + texto + '\n'; 
                }
            }
            return pains;
        }
};

class Tabla {
    public:
        string nombre;
        vector<Columna> cols;

        void print() {
            cout << "Tabla: " << nombre << endl;
            cout << "Columas: " << cols.size() << endl;
            for (auto col : cols) 
                cout << col.paramsInsert();
        }

        void cargar_columnas(sql::ResultSet *columns) {
            while (columns->next()) {
                Columna col;
                col.orden = columns->getInt(1);
                col.nombre = columns->getString(2);
                col.tipo = columns->getString(3);
                col.tamanio = columns->getInt(4);
                col.texto = (columns->getString(4) != "0" ?  (columns->getString(3)  + "(" + columns->getString(4) +  ")" ): columns->getString(3) );  
                col.isPk = (columns->getString(5) == "PRI" ? 1 : 0);
                cols.push_back(col);
            }            
        }
};

int main(void) {
    try {
        sql::Driver *driver;
        sql::Connection *con;
        sql::Statement *stmt;
        sql::ResultSet *tables;

        /* Create a connection */
        driver = get_driver_instance();
        con = driver->connect("tcp://127.0.0.1:3306","db2023","db2023");
        con->setSchema("dbutn");

        stmt = con->createStatement();
        tables = stmt->executeQuery(SQL1.c_str());

        while(tables->next()) {
            Tabla t;
            t.nombre = tables->getString(1);
            SQL2.replace(SQL2.find(REPLACE),REPLACE.length(),t.nombre);
            t.cargar_columnas(stmt->executeQuery(SQL2.c_str()));
            t.print();
        }

        delete tables;
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