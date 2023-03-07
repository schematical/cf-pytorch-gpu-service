# Works with `ami-045a50425ac09a3f5` and Instance type g4dn.xlarge
# NOTE: I had to run this manually line by line otherwise it froze on the last line some how. ~ML 3/2/2023
#start with the basics
export REGION=us-east-1
sudo apt-get update -y

curl -O https://s3.us-east-1.amazonaws.com/amazon-ecs-agent-us-east-1/amazon-ecs-init-latest.amd64.deb
sudo dpkg -i amazon-ecs-init-latest.amd64.deb




sudo sh -c 'echo "ECS_ENABLE_GPU_SUPPORT=true" >> /etc/ecs/ecs.config'

sudo systemctl enable  ecs # https://linuxconfig.org/how-to-start-service-on-boot-on-ubuntu-20-04 # sudo service ecs start

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


sudo apt-get -y install git binutils stunnel4
git clone https://github.com/aws/efs-utils
cd ./efs-utils
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb
sudo systemctl enable  amazon-ecs-volume-plugin
# You might need to run `sudo apt upgrade` if the above command errors out but that updated the kernal - https://linuxtut.com/en/16c2fb959bc36eba1f11/

# sudo mount -t efs -o tls,accesspoint=fs-0c837273b2deff27c fs-0c837273b2deff27c.efs.us-east-1.amazonaws.com /mnt/efs/



if echo $(python3 -V 2>&1) | grep -e "Python 3.6"; then
    sudo wget https://bootstrap.pypa.io/pip/3.6/get-pip.py -O /tmp/get-pip.py
elif echo $(python3 -V 2>&1) | grep -e "Python 3.5"; then
    sudo wget https://bootstrap.pypa.io/pip/3.5/get-pip.py -O /tmp/get-pip.py
elif echo $(python3 -V 2>&1) | grep -e "Python 3.4"; then
    sudo wget https://bootstrap.pypa.io/pip/3.4/get-pip.py -O /tmp/get-pip.py
else
    sudo apt-get -y install python3-distutils
    sudo wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
fi

sudo python3 /tmp/get-pip.py
sudo /usr/local/bin/pip3 install --target /usr/lib/python3/dist-packages botocore # sudo pip3 install botocore




sudo echo "rm /var/lib/ecs/data/agent.db -f && systemctl restart ecs" >> /home/ubuntu/boot.sh
sudo chmod a+x /home/ubuntu/boot.sh
sudo echo "[Unit]
Description=Forces clean the ECS Agent DB on boot

[Service]
ExecStart=/bin/bash /home/ubuntu/boot.sh

[Install]
WantedBy=multi-user.target /etc/systemd/system/schematical-boot.service
Alias=schematical-boot.service
"   >> /etc/systemd/system/schematical-boot.service

sudo systemctl daemon-reload
sudo systemctl enable schematical-boot.service
sudo systemctl status schematical-boot.service



# For now we are pre pulling the model
aws s3 cp s3://sc-cloud-formation-v1/model.ckpt ./model.ckpt


