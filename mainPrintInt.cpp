#include<iostream>
using namespace std;
#include "myl.h"
int main(){

	while(1)
	{
		int x;
		printStr("Enter the number:");
		int res = readInt(&x);
		if(res){

			printStr("The number entered is ");
            printInt(x);
            printStr("\n");

		}
		else
        {
            printStr("The number entered was of incorrect format\n");
        }
        
        
        float y;
        printStr("Enter any floating point number");
        int res=readFlt(&y);
        if(res)
        {
            printStr("The floating point entered is ");
            printFlt(y);
            printStr("\n");

        }
        else
        {
            printStr("The number entered was of incorrect format\n");
        }
     }   
	}  
