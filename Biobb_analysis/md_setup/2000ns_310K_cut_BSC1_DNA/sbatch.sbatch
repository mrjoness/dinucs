#!/bin/bash
#SBATCH --job-name=test_array
#SBATCH --output=outs/array_%A_%a.out
#SBATCH --partition=MOA-15-Ferguson #andrewferguson-gpu #gpu
#SBATCH --account=pi-andrewferguson
#SBATCH --ntasks=1
#SBATCH --output=out.out
#SBATCH --nodes=1            # SET NUM NODES 
#SBATCH --ntasks-per-node=1  # SETS NUM MPI RANKS (1 PER GPU)
#SBATCH --cpus-per-task=6    # SET NUM THREADS 
#SBATCH --gres=gpu:1

# Print the task id.
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

#module load gcc
module unload plumed/2.7
module load openmpi
module load python
module load cuda

NTASKS=$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))
OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

gmx mdrun -v -deffnm md -ntomp $OMP_NUM_THREADS 

