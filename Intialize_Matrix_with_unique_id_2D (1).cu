
#include<stdio.h>
#include<cuda.h>
#define N 5
#define M 6
__global__ void dkernel(unsigned *matrix)
{
  unsigned id = threadIdx.x * blockDim.y + threadIdx.y;
  matrix[id] = id;
}
int main()
{
  dim3 block(M,N,1);
  int i,j;
  unsigned *matrix, *hmatrix;
  cudaMalloc(&matrix,N*M*sizeof(unsigned));
  cudaMallocHost(&hmatrix,N*M*sizeof(unsigned));
  // hmatrix = (unsigned *)malloc(N * M * sizeof(unsigned));
  dkernel<<<1,block>>>(matrix);
  cudaMemcpy(hmatrix,matrix,N*M*sizeof(unsigned),cudaMemcpyDeviceToHost);
  for (i=0;i<N;i++)
  {
    for (j=0;j<M;j++)
    {
      printf("%2d ",hmatrix[i*M+j]);
    }
    printf("\n");
  }
  cudaFree(matrix);

}
