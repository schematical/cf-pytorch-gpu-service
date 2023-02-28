# FROM nvidia/cuda:11.3.1-runtime-ubuntu20.04
FROM 368590945923.dkr.ecr.us-east-1.amazonaws.com/schematicabot-worker:base
ENV CONDA_DIR /opt/conda

RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc wget git libcudnn8 && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda \ && \
     export PATH=$CONDA_DIR/bin:$PATH

ENV  PATH /opt/conda/bin:$PATH
COPY ./src /src
RUN echo "export PATH=$CONDA_DIR/bin:$PATH" >> ~/.bashrc && \
  echo 'conda activate ldm' >> ~/.bashrc && \
  cd ./src && \
  conda env create -f /src/environment.yaml -v && \
  conda init bash && \
  conda install pip -y


SHELL ["conda", "run", "-n", "ldm", "/bin/bash", "-c"]
# RUN python -c "import omegaconf"

RUN aws s3 cp s3://sc-cloud-formation-v1/model.ckpt ./model.ckpt


# CMD ["conda", "run", "--no-capture-output", "-n", "ldm", "python", "scripts/stable_txt2img.py", "--ddim_eta 0.0 --n_samples 1 --n_iter 16 --scale 10.0 --ddim_steps 50  --ckpt Public-Prompts-Pixel-Model.ckpt --prompt "]
# CMD ["/bin/bash", "-c", "conda activate ldm && python scripts/stable_txt2img.py --ddim_eta 0.0 --n_samples 1 --n_iter 16 --scale 10.0 --ddim_steps 50  --ckpt Public-Prompts-Pixel-Model.ckpt --prompt \"a beautiful tropical beach, isometric, 16bitscene\" && ls /outputs/tst-2img-sample/samples "]
CMD ["conda activate ldm && python scripts/stable_txt2img.py --ddim_eta 0.0 --n_samples 1 --n_iter 16 --scale 10.0 --ddim_steps 50  --ckpt model.ckpt --prompt \"a beautiful tropical beach, isometric, 16bitscene\" && ls /outputs/tst-2img-sample/samples "]
# EXPOSE 8080