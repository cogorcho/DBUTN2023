#include <iostream>
#include <fstream>
#include <string>
#include <sys/stat.h>
#include <sys/types.h>
#include <bits/stdc++.h>

using namespace std;

class cfg {
    public:
        string key;
        string val;

        void show() {
            cout << "{\"key\": \"" <<  key << "\", \"val\": \"" << val << "\"}";
        }

        string json() {
            return "{\"key\": \"" + key + "\", \"val\": \"" + val + "\"}";
        }
};

int checkdir(const char* dir) {
    struct stat sb;
    int retval = 2;
    if (stat(dir, &sb) == 0) {
        cout << dir << " is Ok" << endl;
        retval = 0;
    }
    else {
        cout << dir << "is NOT Ok!!!!" << endl;
        retval = 1;
    }
    return retval;
} 

int createdir(const char* dir) {
    if (mkdir(dir, 0755) == -1)
        cerr << "Error: " << strerror(errno) << endl;
    else
        cout << dir << " created" << endl;

    return errno;
}

int main() {
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