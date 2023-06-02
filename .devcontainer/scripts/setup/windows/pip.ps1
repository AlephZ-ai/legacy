Write-Host "setup/windows/pip.ps1"
python -m ensurepip --upgrade | Write-Host
python -m pip install --upgrade pip setuptools wheel | Write-Host
pip install --upgrade platformdirs astroid dill isort mccabe ipykernel ipython-genutils pygments `
  jupyter-client jupyter-core absl-py astunparse flatbuffers gast google-pasta grpcio h5py jax `
  keras libclang numpy opt-einsum protobuf blis catalogue confection cymem murmurhash preshed `
  pydantic jinja2 langcodes murmurhash pathy filelock huggingface-hub imageio lazy_loader `
  networkx pillow tensorboard wrapt py moreutils pylint mypy pandas scipy matplotlib seaborn `
  scikit-learn scikit-image tensorflow torch torchvision transformers spacy jupyter nltk gensim `
  opencv-python aiosqlite pytest pytest-sugar pytest-cov pytest-mock pytest-xdist pytest-xprocess `
  pytest-mock pytest-benchmark pytest-asyncio pytest-asyncio-network-simulator `
  | Write-Host
