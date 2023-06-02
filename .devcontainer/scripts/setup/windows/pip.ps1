Write-Host "setup/windows/pip.ps1"
python -m ensurepip --upgrade | Write-Host
python -m pip install --upgrade pip setuptools wheel | Write-Host
pip install --upgrade platformdirs astroid dill isort mccabe ipykernel ipython-genutils pygments `
  flake8 pytest pytest-sugar pytest-cov pytest-xdist pytest-xprocess pytest-mock pytest-benchmark `
  autopep8 opencv-python aiosqlite absl-py astunparse flatbuffers gast google-pasta grpcio h5py jax `
  keras libclang numpy opt-einsum protobuf blis catalogue confection cymem murmurhash preshed `
  black yapf pydantic jinja2 langcodes murmurhash pathy filelock huggingface-hub imageio lazy_loader `
  networkx pillow tensorboard wrapt py moreutils pylint mypy pandas scipy matplotlib seaborn `
  scikit-learn scikit-image tensorflow torch torchvision transformers spacy nltk gensim `
  jupyter-client jupyter-core jupyter jupyter-lsp jupyterlab jupyterlab-fonts jupyterlab-git jupyterlab-markup `
  jupyterlab_widgets jupyterlab-commands jupyterlab_code_formatter jupyterlab-black jupyterlab-requirements `
  jupyterlab-sparksql jupyterlab-drawio jupyterlab-powerpoint jupyterlab-github jupyterlab-flake8 jupyterlab-lsp `
  jupyterlab-graph-lsp jupyterlab-telemetry jupyterlab-kernelspy jupyterlab-system-monitor `
  jupyterlab-topbar jupyterlab-quickopen jupyter_contrib_core jupyter-contrib-nbextensions `
  | Write-Host
