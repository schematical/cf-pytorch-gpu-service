apt update && \
  apt install --no-install-recommends -y build-essential gcc wget git libcudnn8 curl unzip && \
  wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
  /bin/bash ~/miniconda.sh -b -p /opt/conda \ && \
  export PATH=/opt/conda/bin:$PATH && \
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install

echo "export PATH=$CONDA_DIR/bin:$PATH" >> ~/.bashrc && \
  echo 'conda activate ldm' >> ~/.bashrc

conda init bash && \
  conda install pip -y