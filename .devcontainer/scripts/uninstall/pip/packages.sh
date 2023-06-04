#!/usr/bin/env bash
pip freeze | xargs -I {} pip uninstall -y "{}"
