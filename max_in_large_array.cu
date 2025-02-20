#include<stdio.h>
#include<cuda.h>
#define K 10

__global__ void dkernel(unsigned *arr, int N)
{
  int i;
   unsigned maxi = arr[threadIdx.x*K];
   for(i = threadIdx.x*K ;i< (threadIdx.x*K+K) && i< N ;i++)
   {
    if (arr[i] > maxi)
    {
      maxi = arr[i];
    }
   }
   arr[threadIdx.x] = maxi;
}

int main()
{
  int N = 100;
  unsigned max2;
  unsigned *arr, *arrh;
  cudaMalloc(&arr,N*sizeof(unsigned));
  arrh=(unsigned*)malloc(N*sizeof(unsigned));

  for(int i=0;i<N;i++){
    arrh[i]=i;
  }
  cudaMemcpy(arr,arrh,N*sizeof(unsigned),cudaMemcpyHostToDevice);
  dkernel<<< 1,N/K >>>(arr,N);
  dkernel<<< 1,K >>>(arr,K);
  
  cudaMemcpy(&max2,&arr[0],sizeof(unsigned),cudaMemcpyDeviceToHost);
  printf("max is %d \n",max2);
  return 0;
}
