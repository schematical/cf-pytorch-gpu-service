# Works with `ami-045a50425ac09a3f5` and Instance type g4dn.xlarge
# NOTE: I had to run this manually line by line otherwise it froze on the last line some how. ~ML 3/2/2023
#start with the basics
export REGION=us-east-1
sudo apt-get update -y

curl -O https://s3.us-east-1.amazonaws.com/amazon-ecs-agent-us-east-1/amazon-ecs-init-latest.amd64.deb
sudo dpkg -i amazon-ecs-init-latest.amd64.deb




sudo sh -c 'echo "ECS_ENABLE_GPU_SUPPORT=true" >> /etc/ecs/ecs.config'

sudo systemctl enable --now ecs # https://linuxconfig.org/how-to-start-service-on-boot-on-ubuntu-20-04 # sudo service ecs start

# sudo apt-get install -y build-essential gcc wget git curl unzip && \
wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
/bin/bash ~/miniconda.sh -b -p /opt/conda \ && \
export PATH=/opt/conda/bin:$PATH && \
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
./aws/install

git clone https://github.com/XavierXiao/Dreambooth-Stable-Diffusion
echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc && \
#  echo 'conda init bash' >> ~/.bashrc  && \
#  echo 'conda activate ldm' >> ~/.bashrc

mv Dreambooth-Stable-Diffusion src
cd src
conda env create -f ./environment.yaml -v


conda init bash && \
  conda install pip -y


# For now we are pre pulling the model
aws s3 cp s3://sc-cloud-formation-v1/model.ckpt ./model.ckpt