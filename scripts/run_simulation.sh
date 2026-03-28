#!/usr/bin/env bash
set -euo pipefail

SIM_TIME=${SIM_TIME:-1000}
OUTPUT_DIR=${OUTPUT_DIR:-./output}
MEM_LIMIT=${MEM_LIMIT:-2000000}

mkdir -p "$OUTPUT_DIR"

ulimit -v "$MEM_LIMIT"

c302 run --time "$SIM_TIME" --output "$OUTPUT_DIR/c302_output"

sibernetic run --time "$SIM_TIME" --output "$OUTPUT_DIR/sibernetic_output"

FRAME_DIR="$OUTPUT_DIR/frames"
if [ -d "$FRAME_DIR" ]; then
  ffmpeg -y -framerate 30 -i "$FRAME_DIR/frame_%04d.png" -c:v libx264 -pix_fmt yuv420p "$OUTPUT_DIR/simulation.mp4"
  rm -rf "$FRAME_DIR"
fi
