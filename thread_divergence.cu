#include<stdio.h>
#include<cuda.h>
//assert (x==y || x==z)
if (x == y) x = z;
else x = y;
// thread divergence occurs
x = y+z-x;
// removed thread divergence
