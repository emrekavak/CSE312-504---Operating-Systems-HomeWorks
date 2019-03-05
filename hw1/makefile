all: header
header: main.o 8080emu.o gtuos.o
	g++ -std=c++11 main.cpp 8080emu.cpp gtuos.cpp -o exe
main.o: main.cpp
	g++ -std=c++11 -c main.cpp
8080emuCPP.o: 8080emu.cpp
	g++ -std=c++11 -c 8080emu.cpp
gtuos.o: gtuos.cpp
	g++ -std=c++11 -c gtuos.cpp
clean:
	rm *.o exe
