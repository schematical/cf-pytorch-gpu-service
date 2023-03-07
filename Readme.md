


I created the custom AMI from Ubutu 20.04 with GPU Support. Specifically `ami-045a50425ac09a3f5` and Instance type `g4dn.xlarge`.

#### Helpful Links for building the AMI:

https://docs.aws.amazon.com/batch/latest/userguide/create-batch-ami.html
https://aws.amazon.com/premiumsupport/knowledge-center/ecs-create-custom-AMIs/
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-install.html
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
https://docs.amazonaws.cn/en_us/AmazonECS/latest/developerguide/bootstrap_container_instance.html
https://github.com/aws/amazon-ecs-init
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html

#### Notes on Optimizing Docker Image Size:
https://www.augmentedmind.de/2022/02/06/optimize-docker-image-size/#:~:text=Often%20a%20Docker%20image%20becomes,not%20to%20run%20your%20application.
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/bind-mounts.html
## Notes:
#### Random Resources:
https://medium.com/@michael.smith.qs2/how-to-use-gpus-quickly-and-cheaply-with-aws-batch-and-pytorch-1209320c4e6b
https://towardsdatascience.com/a-complete-guide-to-building-a-docker-image-serving-a-machine-learning-system-in-production-d8b5b0533bde
#### On Instance Run Command:
```
sudo docker run --rm --runtime=nvidia --gpus all 368590945923.dkr.ecr.us-east-1.amazonaws.com/dreambooth-worker-v1-prod-us-east-1:prod -it bash
```
#### Error: `Reason : "RESOURCE:GPU"
In case anyone else stumbles upon this in the future if your using a custom AMI and the ECS agent you need to make sure that you set ECS_ENABLE_GPU_SUPPORT to true in your /etc/ecs/ecs.config or via env vars like the link below.
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html#:~:text=ECS_ENABLE_GPU_SUPPORT

### If the Container Instance is failing to register make sure the `/var/lib/ecs/data/agent.db` is not saved on the AMI: 
Rebuild base AMI with this https://stackoverflow.com/questions/39018180/aws-ecs-agent-wont-start
```
sudo rm /var/lib/ecs/data/agent.db
sudo systemctl restart ecs
sudo systemctl status ecs
```
Possibly remove on start: https://askubuntu.com/questions/814/how-to-run-scripts-on-start-up

tail /var/log/ecs/ecs-agent.log - n 100

#### Cache Checkpoints:
/root/.cache/torch/hub/checkpoints
/root/.cache
#### Optimize for SPOT




sudo mount -t efs -o tls,accesspoint=fs-08dbc4cbdd42b5d3b fs-08dbc4cbdd42b5d3b.efs.us-east-1.amazonaws.com /mnt/efs/