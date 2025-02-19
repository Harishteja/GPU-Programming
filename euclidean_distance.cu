#include<stdio.h>
#include<cuda.h>
#include<math.h>

  struct point
  {
    int a;
    int b ;
  } ;

  __global__ void dkernel(struct point *arrayOfPoints_gpu,int N,float *arr)
    {
     unsigned idx = blockIdx.x*blockDim.x+threadIdx.x;
      float x1 = arrayOfPoints_gpu[blockIdx.x].a;
      float y1 = arrayOfPoints_gpu[blockIdx.x].b;
      float x2 = arrayOfPoints_gpu[threadIdx.x].a;
      float y2 = arrayOfPoints_gpu[threadIdx.x].b;
      
      if (blockIdx.x < threadIdx.x)
         arr[idx]= sqrtf((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));                
    }

 int main()
 {
    int N=5;
    float *arr;
    float *arrh;
    arrh = (float*)malloc(N*N*sizeof(float));
    cudaMalloc(&arr,N*N*sizeof(float));
    struct point arrayOfPoints[N];

    for(int i=0;i<N;i++)
    {
       struct point temp;
       temp.a = i;
       temp.b =i+3;
       arrayOfPoints[i] = temp;
    }
    for(int i=0;i<N;i++){
      printf("a is %d and b is %d \n",arrayOfPoints[i].a,arrayOfPoints[i].b);
    }
    struct point *arrayOfPoints_gpu;
    cudaMalloc(&arrayOfPoints_gpu,N*sizeof(struct point));
    cudaMemcpy(arrayOfPoints_gpu,arrayOfPoints,N*sizeof(struct point),cudaMemcpyHostToDevice);
    dkernel <<< N,N >>>(arrayOfPoints_gpu,N,arr);
    cudaMemcpy(arrh,arr,N*(N-1)/2*sizeof(float),cudaMemcpyDeviceToHost);

    for(int i=0;i<N*(N-1)/2;i++)
    {
        printf("%f ",arrh[i]);
    }
    return 0;   
 }
