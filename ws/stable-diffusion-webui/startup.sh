#!/bin/bash

cd $(dirname $(readlink -f $0))

VRAM="--medvram"
gpu_free_memory_mib=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits)
if [ $gpu_free_memory_mib -lt 2000 ]; then
    VRAM="--lowvram"
fi

COMMANDLINE_ARGS="${VRAM} --opt-split-attention"

cat << EOF > webui-user.sh
#!/bin/bash
#########################################################
# AUTOMATED: DO NOT CHANGE THIS FILE                    #
#########################################################
# original script at https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/webui-user.sh

# Install directory without trailing slash
#install_dir="/home/\$(whoami)"
install_dir="\$(pwd)/cloned"

# Name of the subdirectory
#clone_dir="stable-diffusion-webui"

# Commandline arguments for webui.py, for example: export COMMANDLINE_ARGS="--medvram --opt-split-attention"
export COMMANDLINE_ARGS="${COMMANDLINE_ARGS}"

# python3 executable
#python_cmd="python3"

# git executable
#export GIT="git"

# python3 venv without trailing slash (defaults to ${install_dir}/${clone_dir}/venv)
#venv_dir="venv"

# script to launch to start the app
#export LAUNCH_SCRIPT="launch.py"

# install command for torch
#export TORCH_COMMAND="pip install torch==1.12.1+cu113 --extra-index-url https://download.pytorch.org/whl/cu113"
export TORCH_COMMAND="pip install --no-cache-dir torch==1.12.1+cu113 --extra-index-url https://download.pytorch.org/whl/cu113"

# Requirements file to use for stable-diffusion-webui
#export REQS_FILE="requirements_versions.txt"

# Fixed git repos
#export K_DIFFUSION_PACKAGE=""
#export GFPGAN_PACKAGE=""

# Fixed git commits
#export STABLE_DIFFUSION_COMMIT_HASH=""
#export TAMING_TRANSFORMERS_COMMIT_HASH=""
#export CODEFORMER_COMMIT_HASH=""
#export BLIP_COMMIT_HASH=""

# Uncomment to enable accelerated launch
export ACCELERATE="True"

# Uncomment to disable TCMalloc
#export NO_TCMALLOC="True"

###########################################
EOF

bash <(curl -fsSL https://raw.githubusercontent.com/AUTOMATIC1111/stable-diffusion-webui/master/webui.sh) -f
