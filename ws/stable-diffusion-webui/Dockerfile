FROM nvidia/cuda:12.1.1-base-ubuntu22.04

# google-perftools for tcmalloc
RUN apt update -y && \
    apt install -y wget tig git python3 python3-venv google-perftools libgl1-mesa-dev make vim

# Run the webui.sh script from the stable-diffusion-webui repo
# -f for enable run on root
#CMD ["startup.sh"]
