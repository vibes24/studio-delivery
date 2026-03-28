# MapleLogic ComfyUI - Custom RunPod Worker Image

Custom Docker image for MapleLogic Studio's ComfyUI serverless endpoints on RunPod. Optimized for video generation and stability.

## Included Custom Nodes

1.  **[ComfyUI-VideoHelperSuite](https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite)**
    *   Essential for video generation.
    *   Provides `VHS_VideoCombine` for native MP4 output.
    *   Pre-installed in image for fast cold starts.
2.  **[ComfyUI-Manager](https://github.com/ltdrdata/ComfyUI-Manager)**
    *   Standard management utility.

## Configuration Details

*   **Base Image:** `runpod/worker-comfyui:5.8.5` (Latest stable as of Mar 2026).
*   **ComfyUI Version:** Integrated version in the base worker image.
*   **Model Management:** Models are loaded at runtime from `/runpod-volume/models/`.
    *   **Do NOT bake model weights into this image.** They should reside in your RunPod network volume.
*   **Environment Variables:**
    *   `COMFY_EXTRA_MODEL_PATHS_CONFIG=/runpod-volume/extra_model_paths.yaml` (Points ComfyUI to models on your volume).
    *   `COMFY_LOG_LEVEL=INFO`
    *   `REFRESH_WORKER=true`

## How to Build

1.  Navigate to this directory.
2.  Run the build script:
    ```bash
    ./build.sh 1.0.0
    ```
    This will tag the image as `maplelogic/comfyui-studio:1.0.0` and `maplelogic/comfyui-studio:latest`.

## How to Push

Ensure you are logged into Docker Hub (`docker login`):
```bash
docker push maplelogic/comfyui-studio:1.0.0
docker push maplelogic/comfyui-studio:latest
```

## How to Update RunPod Endpoint

1.  Go to **RunPod Console > Serverless > Endpoints**.
2.  Edit your ComfyUI endpoint or create a new one.
3.  Set the **Container Image** to `maplelogic/comfyui-studio:latest` (or a specific version tag).
4.  Ensure your **Environment Variables** in RunPod match your setup (image defaults should work).
5.  **Save and Deploy.**

## Maintenance & Updates

*   **Stable over Bleeding-Edge:** This image uses pinned versions for stability. Only update the base image or custom node versions when necessary for new features or bug fixes.
*   **Adding Nodes:** Add a new `git clone` and `pip install -r requirements.txt` block to the `Dockerfile`.
*   **Compatibility:** `VideoHelperSuite` requirements (`opencv-python`, `imageio-ffmpeg`) are light and have no known conflicts with the current `worker-comfyui` base.
