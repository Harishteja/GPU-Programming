#include<stdio.h>
#include<cuda.h>
#define N 32

 __global__ void dkernel(int *a){
       unsigned i = threadIdx.x;
        a[i] = 0; 
 }

int main(){
  int a[N],*arr,i;
     cudaMalloc(&arr,sizeof(int)*N);
     dkernel<<< 1,N >>>(arr);
     cudaMemcpy(a,arr,sizeof(int)*N,cudaMemcpyDeviceToHost);
     for (i= 1;i<=N;i++)
         printf("%d",a[i]);
     return 0;   
}
