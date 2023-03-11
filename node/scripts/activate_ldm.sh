cd /home/ubuntu/src/dreambooth
ls -la
conda env create -f ./environment.yaml -v
conda init bash
conda install pip -y
#pip install -e .