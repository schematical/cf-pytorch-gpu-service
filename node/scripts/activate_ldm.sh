cd /home/ubuntu/src
ls -la
conda env create -f ./environment.yaml -v
conda init bash
conda install pip -y
#pip install -e .