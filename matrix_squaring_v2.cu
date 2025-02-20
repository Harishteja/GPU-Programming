#include<stdio.h>
#include<cuda.h>
#define N 64
__global__ void dkernel(unsigned *matrix,unsigned *result){
  unsigned idx = blockIdx.x*blockDim.x+threadIdx.x;
  //for (unsigned ii = 0; ii < N; ++ii) 
   unsigned ii = idx / N;
    unsigned jj = idx % N;
       //for (unsigned jj = 0; jj < N; ++jj)
       
         for (unsigned kk = 0; kk < N; ++kk) {
           result[ii * N + jj] +=
           matrix[ii * N + kk] * matrix[kk * N + jj];
       }
}
int main() {
  unsigned *matrix,*result;
  unsigned *hmatrix;
  int i,j;
  cudaMalloc(&matrix,N*N*sizeof(unsigned));
  cudaMalloc(&result,N*N*sizeof(unsigned));
  hmatrix = (unsigned*)malloc(N*N*sizeof(unsigned));
  for(i=0;i<N;i++){
    for(j=0;j<N;j++){
      hmatrix[i*N+j] = i*N+j;
    }
  }
  cudaMemcpy(matrix,hmatrix,N*N*sizeof(unsigned),cudaMemcpyHostToDevice);
  dkernel<<< N,N >>>(matrix,result);

  cudaMemcpy(hmatrix,result,N*N*sizeof(unsigned),cudaMemcpyDeviceToHost);
  for (i=0;i<N;i++){
    for(j=0;j<N;j++){
      printf("%d ",hmatrix[i*N+j]);
    }
    printf("\n");
  }
return 0;
}
