#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define	MAX_LEN 34			/* maximal input string size */
					/* enough to get 32-bit string + '\n' + null terminator */
extern void assFunc(int buf);



int main(int argc, char** argv)
{
  char buf[MAX_LEN];

  fgets(buf, MAX_LEN, stdin);/* get user input string */
  assFunc(atoi(buf));			/* call your assembly function */
  return 0;
}

int c_checkValidity(int x){
  if(x >= 0) return 1;
  return 0;
}
