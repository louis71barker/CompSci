#include <stdio.h>
#include <stdlib.h>

int main();
/*
{
	int x,n,i;
	double value = 8;
	int binary = 100101;
	x=binary;
	n=value;	

	for (i=0; i<=n; i++)
	{
		printf("%d\n", x<<n);
	}
*/


int x = 5;
int y = 5;
int result = 0;
unsigned int tot = 0; 
for (int i=0;i<32;i++)
{
	unsigned int s=x<<i;
	if (y&(1<<i))
		{
			tot+=s
			printf("add %d=%d\n"s,tot)
		}
	else
		{
			printf("Not Adding %d\n",s)
		}
printf("Result is %d\n",tot)

return 0






}