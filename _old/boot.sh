# Set this up on the base AMI by running `crontab -e` and adding this rule `@reboot /home/ubuntu/boot.sh` then copy this file to `/home/ubuntu/boot.sh`

sudo rm /var/lib/ecs/data/agent.db
sudo systemctl restart ecs