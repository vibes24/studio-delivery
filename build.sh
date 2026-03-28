#!/bin/bash
# MapleLogic ComfyUI Studio — Build Script
# Uses GitHub Container Registry (no Docker Hub needed)
#
# Usage:
#   ./build.sh          — builds locally tagged as latest
#   ./build.sh push     — builds and pushes to ghcr.io

GITHUB_USER="vibes24"  # Your GitHub username
IMAGE="ghcr.io/$GITHUB_USER/comfyui-studio"
VERSION="1.0.0"

echo "🍁 Building MapleLogic ComfyUI Studio image..."
docker build -t $IMAGE:$VERSION -t $IMAGE:latest .

if [ "$1" == "push" ]; then
  echo "📤 Pushing to GitHub Container Registry..."
  echo "First run: echo YOUR_GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USER --password-stdin"
  docker push $IMAGE:$VERSION
  docker push $IMAGE:latest
  echo "✅ Pushed: $IMAGE:$VERSION"
  echo ""
  echo "Update RunPod endpoint to use:"
  echo "  $IMAGE:latest"
else
  echo "✅ Built locally: $IMAGE:latest"
  echo "Run './build.sh push' to push to ghcr.io"
fi
