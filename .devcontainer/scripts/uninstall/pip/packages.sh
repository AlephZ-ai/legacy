#!/usr/bin/env bash
set -ex
pip freeze | xargs -I {} pip uninstall --no-input -y "{}"
