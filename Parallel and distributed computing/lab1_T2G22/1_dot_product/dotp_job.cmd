#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=out_dotp.out
#SBATCH --error=out_dotp.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=00:00:10

source /etc/profile.d/z00-global-profile.sh

module load GCC/10.2.0

make clean >> out_dotp.err && make >> out_dotp.err || exit 1 

./a.out 1 1 100000000
./a.out 2 1 100000000
./a.out 2 2 100000000
./a.out 2 4 100000000
./a.out 2 8 100000000
./a.out 3 1 100000000
./a.out 3 2 100000000
./a.out 3 4 100000000
./a.out 3 8 100000000
