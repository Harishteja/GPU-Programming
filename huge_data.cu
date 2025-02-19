#include<stdio.h>
#include<cuda.h>
#define BLOCKSIZE 1024
__global__ void dkernel(unsigned *vector,unsigned N){
  unsigned idx = blockIdx.x*blockDim.x+threadIdx.x;
  if (idx < N )
  vector[idx] = idx;
}

int main(  int n,char *str[]){
  int i;
  unsigned N = atoi(str[1]);
  unsigned *vector, *hvector;
  cudaMalloc(&vector,N*sizeof(unsigned));
  hvector = (unsigned*)malloc(N*sizeof(unsigned));
  unsigned nblocks = ceil((float)N/BLOCKSIZE);
  printf("nblocks are %d \n",nblocks);

  dkernel <<<nblocks,BLOCKSIZE>>>(vector,N);
  cudaMemcpy(hvector,vector,N*sizeof(unsigned),cudaMemcpyDeviceToHost);
  for( i = 0;i<N;i++){
    printf("%d\n",hvector[i]);
  }
  cudaFree(vector);
  free(hvector);
  return 0;
}
