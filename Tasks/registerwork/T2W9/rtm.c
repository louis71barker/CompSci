#include <stdlib.h>
#include <stdio.h>

#define STATE_EXIT 1<<31
#define STATE_LOAD 1<<30
#define STATE_JUMP 1<<29

#define X1 4
#define X2 5
#define MAXREG X2+1
int reg[MAXREG];

#define ALU_OUT_ADD 4
#define ALU_OUT_SUB 5


#define MAXINST 100
int rom[MAXINST];


void printReg()
{
int i=0;
for(;i<X1;i++)
	printf("R%d:%x\t",i,reg[i]);
printf("X1:%x\t",reg[X1]);
printf("X2:%x\t",reg[X2]);
printf("\n");
printf("\n");
}

void printRomVal(int i)
{
  int b;
  printf("%d\t%x  \t",i,rom[i]);

  for(b=8*sizeof(rom[i]);b-->0;)
	{
	if(rom[i] & (1<<b))
		printf("*");
	else
		printf(".");
	}
  printf("\n\r");
}

int main(int argc, char *argv[])
{
int i;

/*prepare ROM values */
for(i=0;i<100;i++)
	rom[i]=STATE_EXIT;

/*sequence 0 */
#define MOV(FROM,TO) (FROM<<4)|TO
i=0;

rom[i++]=MOV(0,X1);
rom[i++]=MOV(1,X2);
//rom[i++]=MOV(2,1);
rom[i++]=MOV(ALU_OUT_ADD,1);
rom[i++]=MOV(0,X1); 
rom[i++]=MOV(1,X2);
rom[i++]=MOV(ALU_OUT_ADD,0);

//rom[i++]=MOV(1,2);
//rom[i++]=MOV(0,1);
rom[i++]=STATE_JUMP|0;
rom[i++]=STATE_EXIT;


for(i=0;i<MAXREG;i++)
	reg[i]=random()&0xff;
reg[0]=0;
reg[1]=1;
reg[2]=1;
/* Run Machine */
i=0;
printReg();
do{
  int state;
  int from,to;

  printRomVal(i);

  state=rom[i];
  /*Bail if the exit flag is set*/
  if(state&STATE_EXIT)
	{
	return 0;
	}

  if(state&STATE_JUMP)
	i=(rom[i]&0xffff)-1;
  else
	{
	from=(state>>4)&0xf;
	to=state&0xf;
	printf("transfer %d->%d\n",from,to);
	switch(from)
	{
	case ALU_OUT_ADD:reg[to]=reg[X1]+reg[X2];
		reg[X1]=random()&0xf;
		reg[X2]=random()&0xf;
		break;
	case ALU_OUT_SUB:reg[to]=reg[X1]-reg[X2];
		reg[X1]=random()&0xf;
		reg[X2]=random()&0xf;
		break;
	default:
		  reg[to]=reg[from];
	}
	printReg();
	}

  i++;

sleep(5);

  } while(i>=0 && i<MAXINST);

return -1;
}
