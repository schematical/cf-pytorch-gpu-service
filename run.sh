cd /home/ubuntu/src
# echo 'conda run -n ldm /bin/bash -c conda activate ldm'
# conda run -n ldm /bin/bash -c conda activate ldm
# echo "conda init bash"
# conda init bash
echo "conda activate ldm"
# conda activate ldm
# echo "Sending it"
python /home/ubuntu/src/scripts/stable_txt2img.py --ddim_eta 0.0 --n_samples 1 --n_iter 16 --scale 10.0 --ddim_steps 50  --ckpt ./model.ckpt --prompt "a beautiful tropical beach, isometric, 16bitscene"
# ls -la /home/ubuntu/src/outputs/tst-2img-sample/samples

#["conda", "run", "-n", "ldm",  "/bin/bash",  "-c",  "sh", "/home/ubuntu/src/test.sh"]