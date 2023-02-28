FROM 368590945923.dkr.ecr.us-east-1.amazonaws.com/schematicabot-worker:base # nvidia/cuda:11.3.1-runtime-ubuntu20.04
RUN apt update
RUN apt install --no-install-recommends -y build-essential gcc wget git libcudnn8



COPY environment.yaml /environment.yaml
# COPY setup.py /setup.py


# RUN rm ./venv -rf


ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda \
RUN export PATH=$CONDA_DIR/bin:$PATH

ENV  PATH /opt/conda/bin:$PATH
RUN echo $CONDA_DIR
RUN echo $PATH
RUN echo "export PATH=$CONDA_DIR/bin:$PATH" >> ~/.bashrc
RUN echo 'conda activate ldm' >> ~/.bashrc

# SHELL ["/bin/bash","-c"]

RUN conda env create -f /environment.yaml

RUN conda init bash

# RUN python setup.py install
COPY ./src /src
RUN cd ./src
RUN conda install pip -y

SHELL ["conda", "run", "-n", "ldm", "/bin/bash", "-c"]
RUN python -c "import omegaconf"

# COPY --from=builder /root/.local/lib/python3.8/site-packages /usr/local/lib/python3.8/dist-packages
RUN echo $PATH

RUN aws s3 cp s3://sc-cloud-formation-v1/model.ckpt ./model.ckpt


# CMD ["conda", "run", "--no-capture-output", "-n", "ldm", "python", "scripts/stable_txt2img.py", "--ddim_eta 0.0 --n_samples 1 --n_iter 16 --scale 10.0 --ddim_steps 50  --ckpt Public-Prompts-Pixel-Model.ckpt --prompt "]
# CMD ["/bin/bash", "-c", "conda activate ldm && python scripts/stable_txt2img.py --ddim_eta 0.0 --n_samples 1 --n_iter 16 --scale 10.0 --ddim_steps 50  --ckpt Public-Prompts-Pixel-Model.ckpt --prompt \"a beautiful tropical beach, isometric, 16bitscene\" && ls /outputs/tst-2img-sample/samples "]
CMD ["conda activate ldm && python scripts/stable_txt2img.py --ddim_eta 0.0 --n_samples 1 --n_iter 16 --scale 10.0 --ddim_steps 50  --ckpt model.ckpt --prompt \"a beautiful tropical beach, isometric, 16bitscene\" && ls /outputs/tst-2img-sample/samples "]
# EXPOSE 8080