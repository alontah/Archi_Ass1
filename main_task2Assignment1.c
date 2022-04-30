#include <stdio.h>
#define	MAX_LEN 34			/* maximal input string size */
					/* enough to get 32-bit string + '\n' + null terminator */
extern int convertor(char* buf);

void read_number_from_buf(char* buf){
    for (int i=0;i<MAX_LEN;i++){
      if(buf[i]=='\n'){
        buf[i]=0;
        break;
      }
      }
}

int main(int argc, char** argv)
{
  char buf[MAX_LEN ];

  while(1){
  fgets(buf, MAX_LEN, stdin);
  read_number_from_buf(buf);
  if (convertor(buf)==1){
    return 0;
  }
  }
}
