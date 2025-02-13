#include<stdio.h>
#include<cuda.h>
#define N 5
#define M 6
__global__ void dkernel(unsigned *matrix)
{
  unsigned id = blockIdx.x * blockDim.x + threadIdx.x;
  matrix[id] = id;
}
int main()
{
  unsigned *matrix, *hmatrix;
  int i,j;
  cudaMalloc(&matrix,N*M*sizeof(unsigned));
  cudaMallocHost(&hmatrix,N*M*sizeof(unsigned));
  dkernel<<< N,M >>>(matrix);
  cudaMemcpy(hmatrix,matrix,N*M*sizeof(unsigned),cudaMemcpyDeviceToHost);
  for (i=0;i<N;i++)
  {
    for (j=0;j<M;j++)
    {
      printf("%2d ",hmatrix[i*M+j]);
    }
    printf("\n");
  }
  return 0;
}

