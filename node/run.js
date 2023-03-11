const util = require('util');
const exec = util.promisify(require('node:child_process').exec);
const fs = require('fs');

const { spawn } = require('node:child_process');
const SRC_DIR = '/home/ubuntu/node';
const CONDA_LDM_DIR = '/opt/conda/envs/ldm';
const CONDA_DIR = '/opt/conda';
const MODEL_PATH = '/home/ubuntu/node/model.ckpt';

(async () => {
    const condaExists = fs.existsSync(CONDA_DIR);
    if (!condaExists) {
        console.log("Did not find " + CONDA_DIR + "installing");
        const {stdout, stderr} = await exec(`sh ${__dirname}/scripts/install_conda.sh`);
        console.log('stdout:', stdout);
        console.error('stderr:', stderr);
        console.log("Done installing" + CONDA_DIR + "");
    }


    const srcExists = fs.existsSync(SRC_DIR);
    if (!srcExists) {
        console.log("Did not find " + SRC_DIR + "installing");
        const {stdout, stderr} = await exec(`sh ${__dirname}/scripts/install_src.sh`);
        console.log('stdout:', stdout);
        console.error('stderr:', stderr);

        console.log("Done installing" + CONDA_DIR + "");
    }


    const condaLdmExists = fs.existsSync(CONDA_LDM_DIR);
    if (!condaLdmExists) {
        console.log("Did not find " + CONDA_LDM_DIR + "installing");
        const {stdout, stderr} = await exec(`sh ${__dirname}/scripts/install_src.sh`);
        console.log('stdout:', stdout);
        console.error('stderr:', stderr);

        console.log("Done installing" + CONDA_LDM_DIR + "");
    }

    const modelExists = fs.existsSync(MODEL_PATH);
    if (!modelExists) {
        console.log("Did not find " + MODEL_PATH + "installing");
        const {stdout, stderr} = await exec(`sh ${__dirname}/scripts/download_model.sh`);
        console.log('stdout:', stdout);
        console.error('stderr:', stderr);

        console.log("Done installing" + MODEL_PATH + "");
    }


    const mainCmd1 = spawn("conda", ["run", "--no-capture-output", "-n", "ldm", "/bin/bash", "-c", "/home/ubuntu/node/scripts/run.sh test \"a mummy's tomb, isometric, 16bitscene\""]);

    mainCmd1.stdout.on('data', (data) => {
        console.log(`stdout: ${data}`);
    });

    mainCmd1.stderr.on('data', (data) => {
        console.error(`stderr: ${data}`);
    });

    mainCmd1.on('close', (code) => {
        console.log(`child process exited with code ${code}`);
    });
// /opt/conda/envs
})();