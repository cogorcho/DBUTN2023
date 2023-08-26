#ifndef _COLUMNA 
#define _COLUMNA

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

class Columna {
    public:
        int orden;
        string nombre;
        string tipo;
        int tamanio;
        string texto;
        int isPk;

        Columna(sql::ResultSet *);
        void print();
        string paramsInsert();
};

#endif