cd /home/ubuntu/src/dreambooth
ls -la
/opt/conda/install/bin/conda env create -f ./environment.yaml --prefix /opt/conda/install/envs/ldm -v
/opt/conda/install/bin/conda init bash
/opt/conda/install/bin/conda install pip -y
#pip install -e .