#include<stdio.h>
#include<cuda.h>

__global__ void dkernel(unsigned *arr,unsigned *ans,int N,int* i)
{
  unsigned id = threadIdx.x;
  unsigned count = 1;
  if (id<N)
  {
   if (arr[id] == arr[id+1] && arr[id]!=arr[id-1])
   {
    while(arr[id] == arr[id+1])
    {count +=1;
    id +=1;}
    ans[i] = count;
    i++;
   }
   
  }
  }
int main()
{
  unsigned *arr,*dans,*di;
  int N,i=0;
  int arrh[] = {0,0,0,1,1,0,1,0,0,0,1,0,0,0,1,1,1,1,0,1,1,1,0,1,0,0,0,1};
 // int ans[] = {0,0,0,1,1,0,1,0,0,0,1,0,0,0,1,1,1,1,0,1,1,1,0,1,0,0,0,1};
  N=sizeof(arrh)/sizeof(arrh[0]);

  cudaMalloc(&arr,N*sizeof(unsigned));
  cudaMemcpy(arr,arrh,sizeof(arrh),cudaMemcpyHostToDevice);
  cudaMalloc(&dans,N*sizeof(unsigned));
  cudaMalloc(&di,1*sizeof(unsigned));
  cudaMemcpy(di,&i,sizeof(unsigned),cudaMemcpyHostToDevice);
  //cudaMemcpy(dans,ans,sizeof(ans),cudaMemcpyHostToDevice);

  dkernel<<< 1,N >>>(arr,ans,N,di);
  cudaMemcpy(arrh,ans,N*sizeof(unsigned),cudaMemcpyDeviceToHost);

  for (int i=0;i<N;i++)
  {
    printf("%d ",arrh[i]);
  }
  return 0;
}
