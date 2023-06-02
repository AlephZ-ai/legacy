#!/usr/bin/env bash
# init
  set -e
  # shellcheck source=/dev/null
  source "$HOME/.bashrc"
# Setup pip
  python -m ensurepip --upgrade
  python -m pip install --upgrade pip setuptools wheel
  pip install --upgrade platformdirs astroid dill isort mccabe ipykernel ipython-genutils pygments \
    jupyter-client jupyter-core absl-py astunparse flatbuffers gast google-pasta grpcio h5py jax \
    keras libclang numpy opt-einsum protobuf blis catalogue confection cymem murmurhash preshed \
    pydantic jinja2 langcodes murmurhash pathy filelock huggingface-hub imageio lazy_loader \
    networkx pillow tensorboard wrapt py moreutils pylint mypy pandas scipy matplotlib seaborn \
    scikit-learn scikit-image tensorflow torch torchvision transformers spacy jupyter nltk gensim \
    opencv-python aiosqlite pytest pytest-sugar pytest-cov pytest-mock pytest-xdist pytest-xprocess \
    pytest-mock pytest-benchmark pytest-asyncio pytest-asyncio-network-simulator


  # pip install --upgrade "platformdirs>=2.2.0" "astroid<=2.17.0-dev0,>=2.15.4" 'dill>=0.3.6; python_version >= "3.11"' \
  #   "isort<6,>=4.2.5" "mccabe<0.8,>=0.6"
  # pip install --upgrade "ipykernel>=4.1" ipython-genutils pygments "jupyter-client>=4.1" jupyter-core
  # pip install --upgrade "absl-py>=1.0.0" "astunparse>=1.6.0" "flatbuffers>=2.0" "gast<=0.4.0,>=0.2.1" \
  #   "google-pasta>=0.1.1" "grpcio<2.0,>=1.24.3" "h5py>=2.9.0" "jax>=0.3.15" "keras<2.13,>=2.12.0" \
  #   "libclang>=13.0.0" "numpy<1.24,>=1.22" "opt-einsum>=2.3.2" \
  #   "protobuf!=4.21.0,!=4.21.1,!=4.21.2,!=4.21.3,!=4.21.4,!=4.21.5,<5.0.0dev,>=3.20.3"
  # pip install --upgrade "blis<0.8.0,>=0.7.8" "catalogue<2.1.0,>=2.0.6" "confection<1.0.0,>=0.0.1" \
  #   "cymem<2.1.0,>=2.0.2" "murmurhash<1.1.0,>=1.0.2" "preshed<3.1.0,>=3.0.2" \
  #   "pydantic!=1.8,!=1.8.1,<1.11.0,>=1.7.4"
  # pip install --upgrade jinja2 "langcodes<4.0.0,>=3.2.0" "murmurhash<1.1.0,>=0.28.0" "pathy>=0.10.0" \
  #   "preshed<3.1.0,>=3.0.2" "pydantic!=1.8,!=1.8.1,<1.11.0,>=1.7.4"
  # pip install --upgrade "filelock" "huggingface-hub<1.0,>=0.14.1" "imageio>=2.27" "lazy_loader>=0.2" \
  #   "networkx>=2.8" "pillow>=9.0.1"
  # pip install --upgrade "tensorboard<2.13,>=2.12" "wrapt<1.15,>=1.11.0"
  # pip install --upgrade py moreutils pylint mypy pandas scipy matplotlib seaborn scikit-learn scikit-image \
  #   tensorflow torch torchvision transformers spacy jupyter nltk gensim opencv-python
