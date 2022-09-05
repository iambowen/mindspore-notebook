#!/bin/bash

# install cuda/cudnn
UBUNTU_VERSION=${UBUNTU_VERSION:-2004}
CUDA_VERSION=${CUDA_VERSION:-11.1}
echo "installing CUDA and cuDNN"
cd /tmp
declare -A cuda_url_map=()
cuda_url_map["10.1"]=https://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
cuda_url_map["11.1"]=https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda_11.1.1_455.32.00_linux.run
cuda_url=${cuda_url_map[$CUDA_VERSION]}
wget $cuda_url
sh ${cuda_url##*/} --silent --toolkit
rm cuda_11.1.1_455.32.00_linux.run

apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION}/x86_64/3bf863cc.pub
add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION}/x86_64/ /"
add-apt-repository "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu${UBUNTU_VERSION}/x86_64/ /"
apt-get update
declare -A cudnn_name_map=()
cudnn_name_map["10.1"]="libcudnn7=7.6.5.32-1+cuda10.1 libcudnn7-dev=7.6.5.32-1+cuda10.1"
cudnn_name_map["11.1"]="libcudnn8=8.0.5.39-1+cuda11.1 libcudnn8-dev=8.0.5.39-1+cuda11.1"
apt-get install --no-install-recommends ${cudnn_name_map[$CUDA_VERSION]} -y