#ifndef _TABLA
#define _TABLA

#include <iostream>
#include <stdlib.h>
#include <string>
#include <vector>
#include <mysql_connection.h>
#include <cppconn/driver.h>
#include <cppconn/exception.h>
#include <cppconn/resultset.h>
#include <cppconn/statement.h>
#include <Columna.h>

using namespace std;

class Tabla {
    private:
        string SQL; // = "Select ordinal_position, column_name, data_type, concat('',ifnull(character_maximum_length,0)), ifnull(column_key,'NO') from information_schema.columns where table_schema = 'employees' and table_name = 'TNAME' order by ordinal_position";
        string REPLACE; // = "TNAME";
        string initcap(const string);
    public:
        string nombre;
        vector<Columna> cols;
        Tabla(sql::Connection *,string);
        void print();
        void cargar_columnas(sql::ResultSet *); 
        void genClass();
        void genDelete();
};

#endif
