COMPILER=g++
OPTIONS=-Wall -c 
COMPILE=$(COMPILER) $(OPTIONS)
ICPP=-I/usr/include/cppconn
IH=-I./headers
SOURCE=classes
LIBS=-L/usr/lib -lmysqlcppconn
COMPILE=$(COMPILER) $(OPTIONS) $(INCLUDECPP) $(IH) $(LIBS)
BUILD=build

test: test.cpp
	g++ -Wall -I/usr/include/cppconn -o test test.cpp -L/usr/lib -lmysqlcppconn

testsp: testsp.cpp
	g++ -Wall -I/usr/include/cppconn -o testsp testsp.cpp -L/usr/lib -lmysqlcppconn

clean:
	rm build/*.o

Columna.o: $(SOURCE)/Columna.cpp headers/Columna.h
	$(COMPILE) $(SOURCE)/Columna.cpp -o $(BUILD)/Columna.o

Tabla.o: Columna.o $(SOURCE)/Tabla.cpp headers/Tabla.h
	$(COMPILE) $(SOURCE)/Tabla.cpp -o $(BUILD)/Tabla.o

test3.o: test3.cpp 
	$(COMPILE) $(ICPP) -o $(BUILD)/test3.o test3.cpp 

test3: test3.o Tabla.o Columna.o
	$(COMPILER) $(LIBS) $(BUILD)/test3.o $(BUILD)/Tabla.o $(BUILD)/Columna.o -L/usr/lib -lmysqlcppconn -o test3