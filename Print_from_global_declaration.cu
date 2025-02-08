#include<stdio.h>
#include<cuda.h>
char*msg="shriram\n";
#define N 10
__global__ void fun(char *da)
{
  printf("%s",da);
  // a[threadIdx.x] = threadIdx.x * threadIdx.x;
  // printf("%d\n", threadIdx.x*threadIdx.x);
}
int main()
{
  char *da;
  cudaMalloc(&da,N*sizeof(char));
  cudaMemcpy(da,msg,N*sizeof(char),cudaMemcpyHostToDevice);
  fun<<< 1,N >>>(da);
  cudaDeviceSynchronize();
  return 0;
}
