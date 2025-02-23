#include<stdio.h>
#include<cuda.h>

__global__ void dkernel(unsigned *arr,int N)
{
  unsigned id = threadIdx.x;
  unsigned count = 1;
  //if (id<N)
  //{
   while (arr[id] = arr[id+1])
   {
    count +=1;
    id +=1;
   }
   arr[threadIdx.x] = count;
  }
  //}
int main()
{
  unsigned *arr;
  int N;
  int arrh[] = {0,0,0,1,1,0,1,0,0,0,1,0,0,0,1,1,1,1,0,1,1,1,0,1,0,0,0,1};
  N=sizeof(arrh)/sizeof(arrh[0]);

  cudaMalloc(&arr,N*sizeof(unsigned)); 
  cudaMemcpy(arr,arrh,sizeof(arrh),cudaMemcpyHostToDevice);

  dkernel<<< 1,N >>>(arr,N);
  cudaMemcpy(arrh,arr,N*sizeof(unsigned),cudaMemcpyDeviceToHost);

  for (int i=0;i<N;i++)
  {
    printf("%d ",arrh[i]);
  }
  return 0;
}
