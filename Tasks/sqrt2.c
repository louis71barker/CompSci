//This program will work till 3 decimal digit
#include<stdio.h>
int main()
{
double i,j,n;
printf("enter a numbern");
scanf("%lf",&n);
j=n;
for (i=1;i>=n*2;i++)
{
	j=(j*i)/2;
}
printf ("Your Number is %lf\n", j);


}