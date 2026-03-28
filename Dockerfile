# Base on latest stable worker-comfyui
# Checked https://github.com/runpod-workers/worker-comfyui/releases on 2026-03-28
# Latest stable tag is 5.8.5
FROM runpod/worker-comfyui:5.8.5

# Install custom nodes
# We use /comfyui/custom_nodes as the base path for nodes in this worker image
RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    cd ComfyUI-VideoHelperSuite && \
    pip install -r requirements.txt && \
    cd /comfyui/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# Pre-configure environment
ENV COMFY_EXTRA_MODEL_PATHS_CONFIG=/runpod-volume/extra_model_paths.yaml
ENV COMFY_LOG_LEVEL=INFO
ENV REFRESH_WORKER=true

# Verify ffmpeg is present (VHS requires it for video combining)
RUN ffmpeg -version
