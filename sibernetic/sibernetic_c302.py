#!/usr/bin/env python3
"""
Utility to run c302 simulations and process NeuroML2 results.

This module ensures that the NeuroML2 results directory exists before
simulation and gracefully handles the case where expected ``.dat`` files
are missing.
"""

import logging
import os
import subprocess
import sys
from pathlib import Path

# Configure a simple logger for this module.
logging.basicConfig(
    level=logging.INFO,
    format="%(levelname)s: %(message)s"
)


def _ensure_dir(path: Path) -> None:
    """Create *path* if it does not exist.

    Parameters
    ----------
    path:
        The directory to create.
    """
    try:
        path.mkdir(parents=True, exist_ok=True)
    except Exception as exc:  # pragma: no cover - defensive
        logging.error("Failed to create directory %s: %s", path, exc)
        sys.exit(1)


def _dat_files(directory: Path):
    """Yield all ``.dat`` files in *directory*.

    If *directory* does not exist, a warning is logged and the generator
    yields nothing.
    """
    if not directory.is_dir():
        logging.warning("Directory %s does not exist", directory)
        return
    for file in directory.glob("*.dat"):
        yield file


def run_c302(neuroml_file: Path, output_dir: Path, **kwargs):
    """Run a c302 simulation.

    Parameters
    ----------
    neuroml_file:
        Path to the NeuroML2 file to simulate.
    output_dir:
        Directory where simulation results will be written.
    **kwargs:
        Additional command‑line options for c302, passed as ``--key value``.
    """
    _ensure_dir(output_dir)

    cmd = ["c302", "-i", str(neuroml_file), "-o", str(output_dir)]
    for key, value in kwargs.items():
        cmd.extend([f"--{key}", str(value)])

    logging.info("Running command: %s", " ".join(cmd))
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as exc:  # pragma: no cover - defensive
        logging.error("c302 failed: %s", exc)
        sys.exit(1)

    # After simulation, check for .dat files.
    dat_files = list(_dat_files(output_dir))
    if not dat_files:
        logging.warning("No .dat files found in %s", output_dir)
    else:
        logging.info("Found %d .dat file(s) in %s", len(dat_files), output_dir)


if __name__ == "__main__":  # pragma: no cover - script entry point
    if len(sys.argv) < 3:
        print(
            f"Usage: {sys.argv[0]} <neuroml_file> <output_dir>",
            file=sys.stderr,
        )
        sys.exit(1)
    run_c302(Path(sys.argv[1]), Path(sys.argv[2]))
