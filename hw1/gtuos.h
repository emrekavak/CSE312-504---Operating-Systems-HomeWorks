/// EMRE KAVAK 151044085
#ifndef H_GTUOS
#define H_GTUOS
#include "8080emuCPP.h"

#define PRINT_STR 1
#define READ_MEM 2
#define PRINT_MEM 3
#define PRINT_B 4
#define READ_B 7
#define READ_STR 8
 
using namespace std;
class GTUOS{
	public:
		uint64_t handleCall(const CPU8080 & cpu); //  ALL OPERATIONS DOING IN THIS FUNCTION
};

#endif
