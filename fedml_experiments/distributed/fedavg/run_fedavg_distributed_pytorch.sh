#!/usr/bin/env bash
# sh run_fedavg_distributed_pytorch.sh 2 2 1 4 lr hetero 1 1 2 0.03 mnist "./../../../data/mnist" 1
# up error. down right.
# sh run_fedavg_distributed_pytorch.sh 2 2 lr hetero 1 1 4  0.03  mnist "./../../../data/mnist" sgd 1
CLIENT_NUM=$1
WORKER_NUM=$2
MODEL=$3
DISTRIBUTION=$4
ROUND=$5
EPOCH=$6
BATCH_SIZE=$7
LR=$8
DATASET=$9
DATA_DIR=${10}
CLIENT_OPTIMIZER=${11}
CI=${12}

PROCESS_NUM=`expr $WORKER_NUM + 1`
echo $PROCESS_NUM

hostname > mpi_host_file

echo { mpirun -np $PROCESS_NUM -hostfile ./mpi_host_file python3 ./main_fedavg.py \
  --gpu_mapping_file "gpu_mapping.yaml" \
  --gpu_mapping_key "mapping_default" \
  --model $MODEL \
  --dataset $DATASET \
  --data_dir $DATA_DIR \
  --partition_method $DISTRIBUTION  \
  --client_num_in_total $CLIENT_NUM \
  --client_num_per_round $WORKER_NUM \
  --comm_round $ROUND \
  --epochs $EPOCH \
  --client_optimizer $CLIENT_OPTIMIZER \
  --batch_size $BATCH_SIZE \
  --lr $LR \
  --ci $CI }

# mpirun -np 3 -hostfile ./mpi_host_file python3 ./main_fedavg.py --gpu_mapping_file gpu_mapping.yaml --gpu_mapping_key mapping_default --model lr --dataset mnist --data_dir ./../../../data/mnist --partition_method hetero --client_num_in_total 2 --client_num_per_round 2 --comm_round 1 --epochs 1 --client_optimizer sgd --batch_size 4 --lr 0.03 --ci 1