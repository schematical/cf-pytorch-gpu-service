cd /home/ubuntu/src
# echo 'conda run -n ldm /bin/bash -c conda activate ldm'
# conda run -n ldm /bin/bash -c conda activate ldm
echo "\n\n!!!!!!conda init bash\n\n"
conda init bash


echo "\n\n!!!!! cat /root/.bashrc\n\n"
cat /root/.bashrc

echo "\n\n!!!!! conda activate ldm\n\n"
conda activate ldm
echo "\n\n!!!!Sending it\n"
python /home/ubuntu/src/scripts/stable_txt2img.py --outdir $1 --ddim_eta 0.0 --n_samples 1 --n_iter 4 --scale 10.0 --ddim_steps 50  --ckpt ./model.ckpt --prompt $2

echo "\n\n!!!!Pushing to S3\n"
aws s3 cp /home/ubuntu/src/outputs/$1 s3://$S3_BUCKET/$1 --recursive

echo "\n\n!!!!Cleaning Up\n"
rm -rf /home/ubuntu/src/outputs/$1

echo "\n\n!!!!!!DONE\n\n"
#["conda", "run", "-n", "ldm",  "/bin/bash",  "-c",  "sh", "/home/ubuntu/src/test.sh"]

