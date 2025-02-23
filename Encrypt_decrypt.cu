#include<stdio.h>
#include<cuda.h>
//Encrypt: each character c becomes c+1. z becomes a.
__global__ void dkernel(char *str,int length)
{
   unsigned id = threadIdx.x ;
   if (id < length)
   {
    if (str[id]=='z')
    {
       str[id]='a';
    }
    else
     str[id] = str[id] + 1;
   }

}
// Encrypt: each ith character c becomes c+i.
__global__ void dkernel2(char *str,int length)
{
   unsigned id = threadIdx.x ;
   if (id < length)
   {  
    
    //str[id] = 'a' +  ( str[id]+id )%26
      str[id] = 'a' + (str[id]+id-'a')%26;
    //str[id] = str[id] + id%26;
   }

}
int main()
{
    char strh[100];  
    printf("Enter a string: ");
    scanf("%s", strh);  
    printf("You entered: %s\n", strh);
    int len = strlen(strh);

    char *str;
    cudaMalloc(&str,(strlen(strh) + 1) * sizeof(char));
    cudaMemcpy(str,strh,(strlen(strh) + 1) * sizeof(char),cudaMemcpyHostToDevice);
    dkernel2<<< 1,10 >>>(str,len);
    cudaDeviceSynchronize();
    cudaMemcpy(strh,str,(strlen(strh) + 1) * sizeof(char),cudaMemcpyDeviceToHost);
    printf("Encrypted string is %s \n",strh);
    return 0;     
}
