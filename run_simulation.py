#!/usr/bin/env python3
"""
Main simulation controller for OpenWorm pipeline.
Orchestrates c302 and Sibernetic simulations with configurable file copying.
"""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path


def run_c302(config, duration, dt, out_dir):
    """Run c302 neuronal network simulation."""
    cmd = [
        sys.executable, "-m", "c302", "-f", config,
        "-d", str(duration), "-dt", str(dt), "-out_dir", str(out_dir)
    ]
    subprocess.run(cmd, check=True)


def run_sibernetic(config, duration, dt, out_dir):
    """Run Sibernetic biomechanical simulation."""
    cmd = [
        "./Release/Sibernetic", "-f", config,
        "-d", str(duration), "-dt", str(dt), "-out_dir", str(out_dir)
    ]
    subprocess.run(cmd, check=True)


def copy_files(src_dir, dst_dir, keywords=None, file_list=None):
    """Copy simulation outputs based on keywords or explicit file list."""
    src_path = Path(src_dir)
    dst_path = Path(dst_dir)
    dst_path.mkdir(parents=True, exist_ok=True)

    if file_list:
        for fname in file_list:
            src = src_path / fname
            if src.exists():
                shutil.copy2(src, dst_path / fname)
        return

    if not keywords:
        return

    keywords = [k.upper() for k in keywords]
    copy_all = "ALL" in keywords
    raw_only = "SIBERNETIC_RAW" in keywords and len(keywords) == 1

    for item in src_path.iterdir():
        if item.is_file():
            if copy_all or (raw_only and item.suffix == ".raw"):
                shutil.copy2(item, dst_path / item.name)


def main():
    parser = argparse.ArgumentParser(description="OpenWorm simulation controller")
    parser.add_argument("--c302-config", default="C1", help="c302 configuration")
    parser.add_argument("--sibernetic-config", default="default", help="Sibernetic configuration")
    parser.add_argument("--duration", type=float, default=1000.0, help="Simulation duration (ms)")
    parser.add_argument("--dt", type=float, default=0.1, help="Time step (ms)")
    parser.add_argument("--out", default="sim_output", help="Output directory")
    parser.add_argument("--copy-keywords", nargs="*", help="Keywords for file copying (SIBERNETIC_RAW, ALL)")
    parser.add_argument("--copy-files", nargs="*", help="Explicit list of files to copy")
    args = parser.parse_args()

    out_path = Path(args.out)
    c302_out = out_path / "c302"
    sibernetic_out = out_path / "sibernetic"

    run_c302(args.c302_config, args.duration, args.dt, c302_out)
    run_sibernetic(args.sibernetic_config, args.duration, args.dt, sibernetic_out)

    copy_files(c302_out, out_path / "c302_copies", keywords=args.copy_keywords, file_list=args.copy_files)
    copy_files(sibernetic_out, out_path / "sibernetic_copies", keywords=args.copy_keywords, file_list=args.copy_files)


if __name__ == "__main__":
    main()