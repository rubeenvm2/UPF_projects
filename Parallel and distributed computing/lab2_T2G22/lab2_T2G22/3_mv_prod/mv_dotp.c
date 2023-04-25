#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define ind(i, j, nx) (((i)*(nx))+(j))

double *par_read(char *in_file, int *p_size, int rank , int nprocs){
  MPI_File fh;
  MPI_Offset filesize;
  MPI_Status status;
  double *par_read;

  MPI_File_open(MPI_COMM_WORLD, in_file, MPI_MODE_RDONLY, MPI_INFO_NULL, &fh);
  MPI_File_get_size(fh, &filesize);

  filesize = filesize / sizeof(double);
  (*p_size) = filesize/nprocs;
  par_read = (double *) malloc(*p_size*sizeof(double));

  MPI_File_set_view(fh, rank*(*p_size)*sizeof(double), MPI_DOUBLE, MPI_DOUBLE, "native", MPI_INFO_NULL);
  MPI_File_read(fh, par_read, *p_size, MPI_DOUBLE, &status);

  MPI_File_close(&fh);
  return par_read;
}

void main(int argc, char* argv[]){
  int size, rank;
  int p_size;
  double *A, *b;
  double *final_v;
  double total;
  total = 0;
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  A = par_read("/shared/Labs/Lab_2/matrix.bin", &p_size, rank, size);
  b = par_read("/shared/Labs/Lab_2/matrix_vector.bin", &p_size, rank, size);
  double *vector;
  vector = (double*) calloc(p_size*size,sizeof(double));
  final_v = (double *) calloc(p_size*size,sizeof(double));
  MPI_Allgather(&b[0], p_size, MPI_DOUBLE, vector, p_size, MPI_DOUBLE, MPI_COMM_WORLD);
  double start = omp_get_wtime();
  #pragma omp parallel for simd reduction(+:total)
  for(int i = 0; i < p_size; i++){
    for(int j = 0; j < p_size*size; j++){
      total+=A[ind(i,j,p_size*size)]*vector[j];
    }    
    final_v[i] = total;
    total = 0;
  }
  double end = omp_get_wtime();
  double time = end - start;
  if(size == 1){
    printf("%.4e\t%f\t%f\t%f\t%f\n", time, final_v[0], final_v[2048], final_v[4096], final_v[6144]);
  }
  else{  
   printf("%.4e\tc[%d]: %f\n", time, rank, final_v[0]);
  }
  MPI_Finalize();
}
