#start with the basics
#export REGION=us-east-1
#curl -o amazon-ecs-init.rpm https://s3.$REGION.amazonaws.com/amazon-ecs-agent-$REGION/amazon-ecs-init-latest.x86_64.rpm
#sudo yum install -y ./amazon-ecs-init.rpm
#sudo systemctl enable --now ecs
#sudo systemctl status ecs
#sudo docker ps
#sudo systemctl stop ecs
#sudo systemctl stop docker


sudo yum update -y

sudo amazon-linux-extras install -y ecs; sudo systemctl enable --now ecs
sudo yum install -y ecs-init

sudo echo "ECS_ENABLE_GPU_SUPPORT=true" >> /etc/ecs/ecs.config
sudo service ecs start

sudo yum install -y nvidia-container-toolkit-base

# sudo yum install -y nvidia-docker2
sudo amazon-linux-extras install docker -y
sudo yum install -y nvidia-container-toolkit
sudo amazon-linux-extras install docker -y
sudo systemctl --now enable docker

sudo yum install -y nvidia-container-toolkit-base

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.repo | sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker


  yum install -y build-essential gcc wget git libcudnn8 curl unzip && \
  wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
  /bin/bash ~/miniconda.sh -b -p /opt/conda \ && \
  export PATH=/opt/conda/bin:$PATH && \
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install
git clone https://github.com/XavierXiao/Dreambooth-Stable-Diffusion
echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc && \
  echo 'conda init bash' >> ~/.bashrc  && \
  echo 'conda activate ldm' >> ~/.bashrc
#
mv Dreambooth-Stable-Diffusion src
cd src
conda env create -f ./environment.yaml -v


conda init bash && \
  conda install pip -y