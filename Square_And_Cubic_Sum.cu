#include<stdio.h>
#include<cuda.h>
#define N 10
__global__ void dkernel(int *a,int *b,int *c)
{
  c[threadIdx.x] = a[threadIdx.x]*a[threadIdx.x]+ b[threadIdx.x]*b[threadIdx.x]*b[threadIdx.x]; 
}

  int main(){
    int i,a[N],b[N],c[N],*a_gpu[N],*b_gpu[N],*c_gpu[N];
    for (i =1;i<N;i++)
    {
       a[i] = i*i;
    }
        for (i =1;i<N;i++)
    {
       b[i] = i*i*i;
    }
    cudamalloc(&a_gpu,N*sizeof(int));
    cudamalloc(&b_gpu,N*sizeof(int));
    cudamalloc(&c_gpu,N*sizeof(int));
    cudaMemcpy(a_gpu,a,N*sizeof(int),cudaMemcpyHostToDevice);
    cudaMemcpy(b_gpu,b,N*sizeof(int),cudaMemcpyHostToDevice);
    dkernel<<<1,N>>>(a_gpu,b_gpu,c_gpu);
    cudaMemcpy(c,c_gpu,N*sizeof(int),cudaMemcpyDeviceToHost);
    for (i=1;i<N;i++)
    {
      printf("%d",c[i]);
    }
  }
