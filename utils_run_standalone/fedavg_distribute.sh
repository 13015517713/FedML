#!/bin/bash

set -ex

# code checking
cd /home/wcx/gitProject/FedML/fedml_experiments/standalone/fedavg
/home/wcx/anaconda3/bin/pyflakes .

# activate the fedml environment
source "$HOME/miniconda/etc/profile.d/conda.sh"
conda activate fedml

wandb login ee0b5f53d949c84cee7decbe7a629e63fb2f8408
wandb off

assert_eq() {
  local expected="$1"
  local actual="$2"
  local msg

  if [ "$expected" == "$actual" ]; then
    return 0
  else
    echo "$expected != $actual"
    return 1
  fi
}

round() {
  printf "%.${2}f" "${1}"
}

# 1. MNIST standalone FedAvg
sh run_fedavg_distributed_pytorch.sh 2 2 1 4 lr hetero 1 1 2 0.03 mnist "./../../../data/mnist" 1