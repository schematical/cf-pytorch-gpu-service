const util = require('util');
const exec = util.promisify(require('child_process').exec);
const fs = require('fs');

const { spawn } = require('child_process');
const SRC_PATH = '/home/ubuntu/src/environment.yaml';
const CONDA_LDM_DIR = '/opt/conda/install/envs/ldm';
const CONDA_DIR = '/opt/conda/install';
const MODEL_PATH = '/home/ubuntu/src/model.ckpt';
const runSpawn = async (options) => {
    return new Promise((resolve, reject) => {
        console.log("Did not find " + options.path + " installing");

        const mainCmd = spawn(
            options.cmd,
            options.args
        );

        mainCmd.stdout.on('data', (data) => {
            console.log(`stdout: ${data}`);
        });

        mainCmd.stderr.on('data', (data) => {
            console.error(`stderr: ${data}`);
        });

        mainCmd.on('close', (code) => {
            console.log(`child process ${options.path} exited with code ${code}`);
            return resolve();
        });
    });
}
(async () => {
    const condaExists = fs.existsSync(CONDA_DIR);
    if (!condaExists) {
        await runSpawn({
            path: CONDA_DIR,
            cmd: 'sh',
            args: [`${__dirname}/scripts/install_conda.sh`]
        });
    }


    const srcExists = fs.existsSync(SRC_PATH);
    if (!srcExists) {
        await runSpawn({
            path: SRC_PATH,
            cmd: 'sh',
            args: [`${__dirname}/scripts/install_src.sh`]
        });
    }


    const condaLdmExists = fs.existsSync(CONDA_LDM_DIR);
    if (!condaLdmExists) {
        await runSpawn({
            path: CONDA_LDM_DIR,
            cmd: 'sh',
            args: [`${__dirname}/scripts/activate_ldm.sh`]
        });
    }

    const modelExists = fs.existsSync(MODEL_PATH);
    if (!modelExists) {
        await runSpawn({
            path: MODEL_PATH,
            cmd: 'sh',
            args: [`${__dirname}/scripts/download_model.sh`]
        });
    }
    await runSpawn({
        path: '/home/ubuntu/node/scripts/run.sh',
        cmd: 'conda',
        args: ["run", "--no-capture-output", "-n", "ldm", "/bin/bash", "-c", "/home/ubuntu/node/scripts/run.sh test \"a mummy's tomb, isometric, 16bitscene\""]
    });
// /opt/conda/envs
})();