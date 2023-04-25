#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=out_helloworld.out
#SBATCH --error=out_helloworld.err
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=00:00:10

source /etc/profile.d/z00-global-profile.sh

module load GCC/10.2.0
module load OpenMPI/4.1.0-GCC-10.2.0


make clean >> make.out && make >> make.out || exit 1 

mpirun -np 16 ./a.out
