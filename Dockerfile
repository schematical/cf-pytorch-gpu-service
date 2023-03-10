FROM 368590945923.dkr.ecr.us-east-1.amazonaws.com/schematicabot-worker:base
ENV CONDA_DIR /opt/conda

RUN apt update && \
    apt install --no-install-recommends -y curl unzip build-essential gcc wget libcudnn8 && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install  && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda \ && \
    export PATH=/opt/conda/bin:$PATH

ENV  PATH /opt/conda/bin:$PATH

# COPY ./src/Dreambooth-Stable-Diffusion /src
# COPY ./src/model.ckpt /src
COPY ./run.sh /home/ubuntu/run.sh
RUN chmod a+x home/ubuntu/run.sh

RUN echo "export PATH=$CONDA_DIR/bin:$PATH" >> ~/.bashrc
  # echo 'conda activate ldm' >> ~/.bashrc && \
#  cd ./src && \
#  ls -la  && \
  # conda env create -f ./environment.yaml -v && \
RUN rm -rf /root/.cache && \
    rm -rf /home/ubuntu/.cach \

VOLUME ["/opt/conda/envs/ldm"]
VOLUME ["/home/ubuntu/src"]
VOLUME ["/home/ubuntu/.conda"]
VOLUME ["/root/.cache"]
VOLUME ["/home/ubuntu/.cache"]

SHELL ["conda", "run", "-n", "ldm", "/bin/bash", "-c"]
# RUN python -c "import omegaconf"


# CMD ["pwd && ls -la && cd /home && ls -la && cd /home/ubuntu && ls -la && cd /home/ubuntu/src && ls -la" ]
CMD ["conda","run","--no-capture-output", "-n","ldm","/bin/bash","-c","/home/ubuntu/run.sh test \"a mummy's tomb, isometric, 16bitscene\""]
 #      python /home/ubuntu/src/scripts/stable_txt2img.py --ddim_eta 0.0 --n_samples 1 --n_iter 16 --scale 10.0 --ddim_steps 50  --ckpt model.ckpt --prompt \"a beautiful tropical beach, isometric, 16bitscene\" && ls /home/ubuntu/src/outputs/tst-2img-sample/samples "]
