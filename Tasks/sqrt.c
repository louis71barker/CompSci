#include<stdio.h>
#define MAX_NUMBER 5000000000000000000000000000000000000000000000000000000

int find_sqrt(int number)
{
 int i,product = 0;
 for(i=0;i<MAX_NUMBER;i++)
 {
   product = i*i;
   if(product==number)
     return i;
   else if(product>number)
     break;
 }
 return 0;
}

int main()
{
 int n=0,result=0;
 printf("enter the number to find the sqrt\n");
 scanf("%d",&n);
 if(n<0)
 {
  printf("enter only +ve integer value");
  return 0;
 }
 result = find_sqrt(n);
 if(result)
  printf("sqrt of %d is %d\n",n,result);
 else
  printf("not a proper value for finding the sqrt\n");
}