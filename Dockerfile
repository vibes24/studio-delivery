# MapleLogic Studio — ComfyUI with VideoHelperSuite
# Base: runpod/worker-comfyui:5.8.5-base (stable, Mar 20 2026)
FROM runpod/worker-comfyui:5.8.5-base

# Ensure git is available and custom_nodes directory exists
RUN apt-get update && apt-get install -y git --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Create custom_nodes dir if it doesn't exist
RUN mkdir -p /comfyui/custom_nodes

# Install ComfyUI-VideoHelperSuite (required for VHS_VideoCombine MP4 output)
RUN cd /comfyui/custom_nodes && \
    git clone --depth=1 https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    pip install -r ComfyUI-VideoHelperSuite/requirements.txt --no-cache-dir

# Install ComfyUI-Manager (skip if already present in base image)
RUN cd /comfyui/custom_nodes && \
    if [ ! -d "ComfyUI-Manager" ]; then \
        git clone --depth=1 https://github.com/ltdrdata/ComfyUI-Manager.git; \
    else \
        echo "ComfyUI-Manager already installed"; \
    fi

# Verify ffmpeg is present (required by VideoHelperSuite)
RUN ffmpeg -version 2>&1 | head -1

# Pre-configure environment
# Models loaded from network volume at /runpod-volume at runtime
ENV COMFY_EXTRA_MODEL_PATHS_CONFIG=/runpod-volume/extra_model_paths.yaml
ENV COMFY_LOG_LEVEL=INFO
ENV REFRESH_WORKER=true
