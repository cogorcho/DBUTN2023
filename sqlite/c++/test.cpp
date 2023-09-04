#include <iostream>
#include <stdio.h>
#include <sqlite3.h> 
#include <string>
#include <cstring>
#include <vector>

using namespace std;


class Columna {
   public:
      string tabla;
      int id;
      string name;
      string type;
      int is_pk;
      int is_not_null;

      Columna() {}

      Columna(string ptabla, int pid, string pname, string ptype, int pis_pk, int p_is_not_null) {
         tabla = ptabla;
         id = pid;
         name = pname;
         type = ptype;
         is_pk = pis_pk;
         is_not_null = p_is_not_null;
      }

      void print() {
         cout << "\tColumna: " << id << ", " << name << ", " << type << ", PK: " << is_pk << endl;
      }
};

class Tabla {
   public:
      string nombre;
      vector<Columna> columnas;

      void print() {
         cout << "Tabla: " << nombre << "(" << columnas.size() << ")" << std::endl;
         for (auto col : columnas)
            col.print();
      } 
};

vector<Tabla> tablas;
vector<Columna> columnas;

static int callback(void *NotUsed, int argc, char **argv, char **azColName) {
   int i;
   for(i = 0; i<argc; i++) {
      Tabla t;
      t.nombre = argv[i];
      tablas.push_back(t);
   }
   return 0;
}

static int callback2(void *NotUsed, int argc, char **argv, char **azColName) {
   int i;
   Columna col = Columna();
   for(i = 0; i<argc; i++) {
      //printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
      if (strcmp(azColName[i], "table_name") == 0) {
         col.tabla.assign(argv[i]);
         //cout << "Asigno col.tabla: " <<  col.tabla << std::endl;
      }
      if (strcmp(azColName[i],"col_id") == 0) {
         col.id = atoi(argv[i]);
         //cout << "Asigno col.id: " << col.id << std::endl;
      } 
      if (strcmp(azColName[i], "col_name") == 0) {
         col.name.assign(argv[i]);
         //cout << "Asigno col.name: " <<  col.name << std::endl;
      } 

      if (strcmp(azColName[i], "col_type") == 0)
         col.type = argv[i];
      if (strcmp(azColName[i], "col_is_pk") == 0)
         col.is_pk = atoi(argv[i]);
      if (strcmp(azColName[i], "col_is_not_null") == 0)
         col.is_not_null = atoi(argv[i]);
   }
   columnas.push_back(col);
   //col.print();
   return 0;
}

int getTablas(sqlite3* db) {
   char *zErrMsg = 0;
   const char* sql = "select name from sqlite_master where type = 'table' and name != 'sqlite_sequence'";
   int rc = sqlite3_exec(db, sql, callback, 0, &zErrMsg);
   return rc;
}

int getCols(sqlite3* db, string tabla) {
   char *zErrMsg = 0;
   const string sql = "SELECT \
m.name AS table_name, \
p.cid AS col_id,\
p.name AS col_name, \
p.type AS col_type, \
p.pk AS col_is_pk, \
p.dflt_value AS col_default_val, \
p.[notnull] AS col_is_not_null \
FROM sqlite_master m \
LEFT OUTER JOIN pragma_table_info((m.name)) p \
ON m.name <> p.name \
WHERE m.type = 'table' \
AND m.name = '" + tabla + "' ORDER BY table_name, col_id";
//cout << "In getcols(): " << tabla << std::endl;

   int rc = sqlite3_exec(db, sql.c_str(), callback2, 0, &zErrMsg);
   //cout << "getcols(" << tabla << ") " << rc << std::endl;
   return rc;   
}


int main(int argc, char* argv[]) {
   sqlite3 *db;
   int rc;
   char *zErrMsg = 0;

   rc = sqlite3_open("escuelas.sqlite", &db);

   if( rc ) {
      fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
      return(0);
   } else {
      fprintf(stderr, "Opened database successfully\n");
      rc = getTablas(db);
      for(auto t: tablas) {
         rc = getCols(db,t.nombre);
         t.columnas = columnas;
         t.print();
         columnas.clear();
      }
   }
   sqlite3_close(db);
}

