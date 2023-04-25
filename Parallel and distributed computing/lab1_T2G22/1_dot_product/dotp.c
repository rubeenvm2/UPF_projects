#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

void main(int argc, char* argv[]){
    int size, ex, nthreads;
  
    sscanf(argv[3], "%d", &size);
    sscanf(argv[2], "%d", &nthreads);
    sscanf(argv[1], "%d", &ex);
  
    int total = 0;
    int* a = malloc(sizeof(int)*size);
    int* b = malloc(sizeof(int)*size);
    srand(1);
    for(int i = 0; i < size; i++){
        a[i] = (int) (rand() % size - size/2);
        b[i] = (int) (rand() % size - size/2);
    }
    if(ex == 1){   
	printf("Exercici 1\n");
        double start = omp_get_wtime();
        for(int i=0; i < size; i++){
            total+=a[i]*b[i];
        }
        double end = omp_get_wtime();
        double time = end-start;
        printf("%.4e\t%i\n", time, total);
    }
    else if(ex == 2){
	printf("Exercici 2, nthreads %d\n", nthreads);
        omp_set_num_threads(nthreads);
        int i;
        double start = omp_get_wtime();
        #pragma omp parallel for reduction(+:total)
        for(i = 0; i < size; i++){
            total+=a[i]*b[i];
        }
        double end = omp_get_wtime();
        double time = end-start;
        printf("%.4e\t%i\n", time, total);
    }
    else{
     	printf("Exercici 3, nthreads %d\n", nthreads);
	double start = omp_get_wtime();
	#pragma omp parallel for simd reduction(+:total)
	for(int i = 0; i < size; i++){
	    total+=a[i]*b[i];
	}
	double end = omp_get_wtime();
	double time = end - start;
	printf("%.4e\t%i\n", time, total);
    }
}
