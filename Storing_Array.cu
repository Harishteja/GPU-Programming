#include<stdio.h>
#include<cuda.h>
#define N 10
__global__ void fun()
{

  printf("%d\n", threadIdx.x*threadIdx.x);

}
int main(){
   
  fun<<< 1,N >>>();
  // dkernel<<< 1,1 >>>();
  // dkernel<<< 1,1 >>>();

  cudaDeviceSynchronize();
  
  return 0;
}
