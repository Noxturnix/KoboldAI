#!/bin/bash
export PYTHONNOUSERSITE=1
git submodule update --init --recursive
if [[ $1 = "cuda" || $1 = "CUDA" ]]; then
wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
bin/micromamba create -f environments/huggingface.yml -r runtime -n koboldai -q -y
# Weird micromamba bug causes it to fail the first time, running it twice just to be safe, the second time is much faster
bin/micromamba create -f environments/huggingface.yml -r runtime -n koboldai -q -y
exit
fi
if [[ $1 = "rocm" || $1 = "ROCM" ]]; then
wget -qO- https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
bin/micromamba create -f environments/rocm.yml -r runtime -n koboldai-rocm -q -y
# Weird micromamba bug causes it to fail the first time, running it twice just to be safe, the second time is much faster
bin/micromamba create -f environments/rocm.yml -r runtime -n koboldai-rocm -q -y
exit
fi
echo Please specify either CUDA or ROCM
