#include <iostream>
#include <fstream>
#include <string>
#include <sys/stat.h>
#include <sys/types.h>
#include <bits/stdc++.h>
#include <vector>

#define DIR_NOT_EXISTS = 1

using namespace std;

class KeyVal {
    public:
        string key;
        string value;
        KeyVal(string pKey, string pValue) [
            key = pKey;
            value = pValue;
        ]
}

class Config {
    public:
        string key;
        string val;
        static const string base = "BASEDIR";
        string basedir;
        vector<KeyVal> kvs;

        void show() {
            cout << "{\"key\": \"" <<  key << "\", \"val\": \"" << val << "\"}";
        }

        string json() {
            return "{\"key\": \"" + key + "\", \"val\": \"" + val + "\"}";
        }

        Config(const char* basedir) {
            if (!create_dir(basedir))
          
            cargar_config();
        }
    
    private:
        const static string cfgfilename = "config.dat";
        fstream cfgfile;
        void cargar_config() {
            if (check_dir())

        }
};

int check_dir(const char* dir) {
    struct stat sb;
    if (stat(dir, &sb) == 0) {
        cout << dir << " OK" << endl;
        retval = 1;
    }
    else {
        cout << dir << " en Error" << endl;
        retval = 0;
    }
    return retval;
} 

int create_dir(const char* dir) {
    if (!check_dir(dir)) {
        if (mkdir(dir, 0755) == -1)
            cerr << "Error creando " << dir << ": " << strerror(errno) << endl;
        else
            cout << dir << " creado" << endl;
        return errno;
    }   
    else {
        return 0;
    }
}

int main(int argc, char **argv) {
    fstream newfile;

    newfile.open("config/config.dat", ios::in);

    if (newfile.is_open()) {
        string sa;
        cfg cfgitem;
        while (std::getline(newfile,sa)) {
            cout << sa << endl;
            int pos = sa.find("=");
            cfgitem.key = sa.substr(0,pos);
            cfgitem.val = sa.substr(pos + 1);
            cfgitem.show();
            cout << endl;
            cout << cfgitem.json() << endl;
            checkdir(cfgitem.val.c_str());
            createdir((cfgitem.val + "/classes").c_str());
            createdir((cfgitem.val + "/headers").c_str());
            createdir((cfgitem.val + "/data").c_str());
            createdir((cfgitem.val + "/storedprocedures").c_str());
        }
        newfile.close();
    }
    else {
        cout << "las bolas..." << endl;
    }

}