DOCKER_IMAGE="your_docker_image_name"
USERNAME="sskundu"
MOUNT_DIRECTORY="path_to_mount_directory"

JOB_NAME="fold0"
runai submit --name $JOB_NAME \
    --image $DOCKER_IMAGE \
    --run-as-user \
    --project $USERNAME \
    -v $MOUNT_DIRECTORY \
    --backoff-limit 0 \
    --gpu 1 \
    --host-ipc \
    --command -- nnUNetv2_train 800 2d 0 --npz

JOB_NAME="fold1"
runai submit --name $JOB_NAME \
    --image $DOCKER_IMAGE \
    --run-as-user \
    --project $USERNAME \
    -v $MOUNT_DIRECTORY \
    --backoff-limit 0 \
    --gpu 1 \
    --host-ipc \
    --command -- nnUNetv2_train 800 2d 1 --npz
    
########################################### FOR SLURM ##########################################

#!/bin/bash

# Submit fold0 job
sbatch <<EOT
#!/bin/bash
#SBATCH --job-name=fold0
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=1:00:00
#SBATCH --output=fold0_%j.out
#SBATCH --error=fold0_%j.err

DOCKER_IMAGE="your_docker_image_name"
MOUNT_DIRECTORY="path_to_mount_directory"

USERNAME="sskundu"

srun singularity exec --nv -B $MOUNT_DIRECTORY:/mnt $DOCKER_IMAGE nnUNetv2_train 800 2d 0 --npz
EOT

# Submit fold1 job
sbatch <<EOT
#!/bin/bash
#SBATCH --job-name=fold1
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=1:00:00
#SBATCH --output=fold1_%j.out
#SBATCH --error=fold1_%j.err

DOCKER_IMAGE="your_docker_image_name"
MOUNT_DIRECTORY="path_to_mount_directory"

USERNAME="sskundu"

srun singularity exec --nv -B $MOUNT_DIRECTORY:/mnt $DOCKER_IMAGE nnUNetv2_train 800 2d 1 --npz
EOT
