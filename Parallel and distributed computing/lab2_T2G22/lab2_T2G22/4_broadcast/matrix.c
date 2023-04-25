#include <omp.h>
#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#define ind(i, j, nx) (((i)*(nx))+(j))

int *new_matrix(int size, int rank){
  int *A;
  A  = (int*)malloc(size*size*sizeof(int));
  for(int i = 0; i < size; i++){
    for(int j = 0; j < size; j++){
      if(i == j){        
        A[ind(i,j,size)] = rank;
      }
      else{
        A[ind(i,j,size)] = 0;
      }
    }
  }
  return A;
}

void print_matrix(int *matrix, int size){
  for(int i = 0; i< size; i++){
    for(int j = 0; j < size; j++){
      printf("%d ", matrix[ind(i,j,size)]);
    }
    printf("\n");
  }
}

void main(int argc, char* argv[]){
  int size, rank;
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  int *matrix, *final_matrix;
  matrix = (int*)malloc(size*size*sizeof(int));
  matrix = new_matrix(size, rank);

  if(rank == 0){
    final_matrix = (int*)malloc(size*size*sizeof(int));
    printf("Initial matrix (rank 0)\n");
    print_matrix(matrix, size);
  }
  else{
    final_matrix = NULL;
  }
  
  MPI_Datatype diagonaltype;
  MPI_Type_vector(size, 1, size + 1, MPI_INT, &diagonaltype);
  MPI_Type_commit(&diagonaltype);
  
  MPI_Gather(&matrix[ind(0, 0, size)], 1, diagonaltype, final_matrix, size, MPI_INT, 0, MPI_COMM_WORLD);
  
  if(rank == 0){
    printf("\nFinal matrix (rank 0)\n");
    print_matrix(final_matrix, size);
  }
  MPI_Type_free(&diagonaltype);
  MPI_Finalize();
}
