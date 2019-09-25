#define BUFF 20
#include "myl.h"
#define SYS_READ 0
#define STDIN_FILENO 0

int printInt(int n){

	char buff[BUFF], zero = '0';
	int i = 0, j, k, bytes;
	if(n == 0)buff[i++] = zero;
	else{
		if(n < 0){
			buff[i++] = '-';
			n = -n;
		}
		while(n){
			int dig = n%10;
			buff[i++] = (char)(zero + dig);
			n = n/10;
		}
		if(buff[0] == '-')j = 1;
		else j = 0;
		k = i - 1;
		while(j < k){
			char temp = buff[j];
			buff[j++] = buff[k];
			buff[k--] = temp;
		}
	}
	buff[i] = '\n';
	bytes = i+1;
	__asm__ __volatile__(

		"movl $1, %%eax \n\t"
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		:"S"(buff), "d"(bytes)
		);
	return bytes;
}

int printStr(char* str){

	int char_count = 0;
	for(char_count = 0; str[char_count]!='\0'; char_count++);
	__asm__ __volatile__ (
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t" 
        // making the  syscall
        "syscall \n\t"
        :
        :"S"(str), "d"(char_count)
    );
	return char_count; 
}

int readInt(int *n){

	char buff[BUFF];
	int len, i, num, flag  = 0;
	asm volatile("syscall" 
      : "=a" (len) 
      : "0" (SYS_READ), "D" (STDIN_FILENO), "S" (buff), "d" (sizeof(buff))
      : "rcx", "r11", "memory", "cc");

	len = len - 1;
	buff[len] = '\0';	//assign the last element of buff[] to be NULL
	i = len - 1 ;		// i = char just before the NULL
	while(i >= 0 && buff[i--]== ' '); //if blank spaces are present then decrease i
	buff[i+2] = '\0';
	len = i+2;	//len points to the null element after the last digit	
	i = -1; 
	while(buff[++i] == ' '); // remove spaces from the front of buff
	if(buff[i] == '-')
	{
		flag++;
		i++;
	}
	if(buff[i] >= '0' && buff[i] <= '9')
	{
		num = buff[i] - '0';
		i++;
	} 
	else return ERR;
	while(i < len)
	{
		if(buff[i] < '0' || buff[i] > '9')
			return ERR;
		num = num*10 + (buff[i] - '0');
		i++;
	}
	if(flag)
		num = -num;
	*n = num;
	return OK;
}

int readFlt(float* f){

	char buff[BUFF];
	int len, i, integer = 0, flag = 0, f1 = 0;
	float frac = 0.1, dec = 0, num;

	asm volatile("syscall" 
      : "=a" (len) 
      : "0" (SYS_READ), "D" (STDIN_FILENO), "S" (buff), "d" (sizeof(buff))
      : "rcx", "r11", "memory", "cc");

	buff[--len] = '\0';	//assign the last element of buff[] to be NULL
	i = len - 1;//i = char just before the NULL
	while(i >= 0 && buff[i--]==' ');	// remove spaces from the front of buff
	buff[i+2] = '\0';
	len = i+2;	//len points to the null element after the last digit	
	i = -1;
	while(buff[++i] == ' ');	// remove spaces from the front of buff
	if(buff[i] == '-')
	{
		flag++;			//check if number is positive or negative
		i++;
	}
	if(buff[i] >= '0' && buff[i] <= '9')
	{
		integer = buff[i] - '0';
		i++;
	}
	else if(buff[i] == '.')
	{
		f1 = 1; 	//check for decimal
		i++;	
	}
	else return ERR;
	for(;i<len;i++)
	{
		if(buff[i] == '.'){

			if(f1 == 1)
				return ERR;
			f1 = 1;
			continue;
		}
		else if(buff[i] < 0 || buff[i] > 9)
			return ERR;
		else if(f1){
			dec = dec + frac*(buff[i] - '0');
			frac = frac * 0.1;
		}else{
			integer = integer * 10 + (buff[i] - '0');
		}

	}

	num = integer + dec;
	if(flag)
		num = -num;
	*f = num;
	return OK; 
}
int printFlt(float f)
{

	int integer = (int)f;
	int i = 1, len = 7;
	float fraction = f - (float)integer;
	char buff[BUFF];
	if(integer == 0 && fraction < 0)printStr("-");
	len += printInt(integer);
	if(fraction < 0)fraction = -fraction;
	buff[0] = '.';
	while(fraction > 0 && i <= 6){

		fraction = fraction*10;
		integer = (int)fraction;
		buff[i++] = integer + '0';
		fraction = fraction - integer;
	}
	while(i<=6)
		buff[i++] = '0';
	buff[i] = '\0';
	printStr(buff);
	return len;
}
