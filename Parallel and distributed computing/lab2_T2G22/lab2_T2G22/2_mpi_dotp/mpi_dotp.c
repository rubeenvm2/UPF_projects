#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

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
  double *p, *q;
  double total, final_v;
  total = 0;
  final_v = 0;
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  p = par_read("/shared/Labs/Lab_2/array_p.bin", &p_size, rank, size);
  q = par_read("/shared/Labs/Lab_2/array_q.bin", &p_size, rank, size);
  double start = omp_get_wtime();
  #pragma omp parallel for simd reduction(+:total)
  for(int i = 0; i < p_size; i++){
    total+=p[i]*q[i];
  }  
  MPI_Allreduce(&total, &final_v, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);
  double end = omp_get_wtime();
  double time = end - start;
  printf("%.4e\t%f\n", time, final_v);
  
  MPI_Finalize();
}
