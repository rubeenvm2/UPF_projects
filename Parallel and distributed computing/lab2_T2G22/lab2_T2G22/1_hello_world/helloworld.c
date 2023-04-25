#include "mpi.h"
#include <stdio.h>
#include <string.h>

int main( int argc, char *argv[] ) {
  int rank, size;
  MPI_Init( &argc, &argv );
  char processor_name[MPI_MAX_OBJECT_NAME];
  int name_len;
  MPI_Comm SPLIT_COMM_;
  MPI_Comm_rank( MPI_COMM_WORLD, &rank );
  MPI_Comm_size( MPI_COMM_WORLD, &size );
  MPI_Comm_get_name(MPI_COMM_WORLD, processor_name, &name_len);
  if(rank == 0){
    printf("PHASE 1\n\n");
  }
  for(int i=0; i<size; ++i){
    if(rank==i) printf( "Hi, I'm rank %d. My communicator is %s and has a size of %d processes.\n", rank, processor_name ,size );
    fflush(stdout);
    MPI_Barrier(MPI_COMM_WORLD);
  }
  fflush(stdout);
  MPI_Barrier(MPI_COMM_WORLD);
  
  if(rank == 0){
    printf("\nPHASE 2\n\n");
  }
  int color = rank/4;
  char processor_name_2[MPI_MAX_OBJECT_NAME];
  char comm_name[MPI_MAX_OBJECT_NAME];
  int x = 4;
  int rank_comm_2,size_comm_2;
  MPI_Comm_split(MPI_COMM_WORLD, color, x,&SPLIT_COMM_);
  snprintf(processor_name_2, sizeof(processor_name_2), "SPLIT_COMM_%d", color);
  MPI_Comm_set_name(SPLIT_COMM_, processor_name_2);
  MPI_Comm_get_name(SPLIT_COMM_, comm_name, &name_len);
  MPI_Comm_rank(SPLIT_COMM_, &rank_comm_2);
  MPI_Comm_size(SPLIT_COMM_, &size_comm_2);
  for(int i = 0; i < size; i++){
    if(rank == i) printf("Hi, I was rank %d. My communicator is %s and has a size of %d processes. Now I'm rank %d in communicator %s which has %d processes.\n",rank, processor_name, size, rank_comm_2, comm_name, size_comm_2);
   // fflush(stdout);
    MPI_Barrier(MPI_COMM_WORLD);
  }
  fflush(stdout);
  MPI_Barrier(MPI_COMM_WORLD);
  

  if(rank == 0){
    printf("\nPHASE 3\n\n");
  }
  char comm_name_3[MPI_MAX_OBJECT_NAME];
  char comm_set_name_3[MPI_MAX_OBJECT_NAME];
  snprintf(comm_set_name_3,sizeof(comm_set_name_3), "EVEN_COMM");
  MPI_Group group_world;
  MPI_Group even_group;
  int group[size/2];
  for(int i = 0; i < size; i++){
    if(i%2 == 0) group[i/2] = i;
  }
  MPI_Comm EVEN_COMM;
  MPI_Comm_group(MPI_COMM_WORLD, &group_world);
  MPI_Group_incl(group_world, size/2, group, &even_group);
  int size_even_comm, rank_even_comm;
  MPI_Comm_create_group(MPI_COMM_WORLD, even_group,0, &EVEN_COMM);
  if(EVEN_COMM == MPI_COMM_NULL);
  else{  
    MPI_Comm_set_name(EVEN_COMM, comm_set_name_3);
    MPI_Comm_get_name(EVEN_COMM, comm_name_3, &name_len);
    MPI_Comm_rank(EVEN_COMM, &rank_even_comm);
    MPI_Comm_size(EVEN_COMM, &size_even_comm);
  }
  for(int i = 0; i < size; i++){
    if(rank == i && i%2==0) printf("Hi, I was rank %d in communicator %s which had %d processes. Now I'm rank %d in communicator %s which has %d processes.\n", rank_comm_2, comm_name, size_comm_2, rank_even_comm, comm_name_3, size_even_comm);
    MPI_Barrier(MPI_COMM_WORLD);
  }
  fflush(stdout);
  MPI_Barrier(MPI_COMM_WORLD);

  if(rank == 0){
    printf("\nPHASE 4\n\n");
  }
  char comm_name_4[MPI_MAX_OBJECT_NAME];
  char comm_set_name_4[MPI_MAX_OBJECT_NAME];
  snprintf(comm_set_name_4,sizeof(comm_set_name_3), "ODD_COMM");
  MPI_Group odd_group;
  for(int i = 0; i < size; i++){
    if(i%2 != 0) group[i/2] = i;
  }
  MPI_Comm ODD_COMM;
  MPI_Group_incl(group_world, size/2, group, &odd_group);
  int size_odd_comm, rank_odd_comm;
  MPI_Comm_create_group(MPI_COMM_WORLD, odd_group,0, &ODD_COMM);
  if(ODD_COMM == MPI_COMM_NULL);
  else{  
    MPI_Comm_set_name(ODD_COMM, comm_set_name_4);
    MPI_Comm_get_name(ODD_COMM, comm_name_4, &name_len);
    MPI_Comm_rank(ODD_COMM, &rank_odd_comm);
    MPI_Comm_size(ODD_COMM, &size_odd_comm);
  }
  for(int i = 0; i < size; i++){
    if(rank == i && i%2!=0) printf("Hi, I was rank %d in communicator %s which had %d processes. Now I'm rank %d in communicator %s which has %d processes.\n", rank, processor_name, size, rank_odd_comm, comm_name_4, size_odd_comm);
    MPI_Barrier(MPI_COMM_WORLD);
  }
  fflush(stdout);
  MPI_Barrier(ODD_COMM);
  MPI_Finalize();
  return 0;
}
