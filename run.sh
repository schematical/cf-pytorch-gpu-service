cd /home/ubuntu/src
# echo 'conda run -n ldm /bin/bash -c conda activate ldm'
# conda run -n ldm /bin/bash -c conda activate ldm
echo "!!!!!!conda init bash"
conda init bash


# echo "!!!!! cat /root/.bashrc"
# cat /root/.bashrc

echo "!!!!! conda activate ldm"
conda activate ldm
echo "!!!!Sending it. Dir: $1 Prompt: $2"
python /home/ubuntu/src/scripts/stable_txt2img.py --outdir "outputs/$1" --ddim_eta 0.0 --n_samples 1 --n_iter 4 --scale 10.0 --ddim_steps 50  --ckpt ./model.ckpt --prompt "$2"

echo "!!!!Pushing to S3"
aws s3 cp /home/ubuntu/src/outputs/$1 s3://$S3_BUCKET/$1 --recursive

echo "!!!!Cleaning Up"
rm -rf /home/ubuntu/src/outputs/$1

echo "!!!!!!DONE"
#["conda", "run", "-n", "ldm",  "/bin/bash",  "-c",  "sh", "/home/ubuntu/src/test.sh"]

