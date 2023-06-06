Write-Host "setup/windows/pip.ps1"
python -m ensurepip --upgrade | Write-Host
python -m pip install --upgrade pip setuptools wheel pygobject pycairo | Write-Host
pip install --no-input --user --upgrade --extra-index-url=https://pypi.nvidia.com pip setuptools wheel `
  pygobject pycairo platformdirs astroid dill isort mccabe ipykernel ipython-genutils pygments flake8 tqdm rich ruff `
  pytest pytest-sugar pytest-cov pytest-xdist pytest-xprocess pytest-mock pytest-benchmark autopep8 opencv-python `
  aiosqlite absl-py astunparse flatbuffers gast google-pasta grpcio h5py jax keras libclang numpy opt-einsum protobuf `
  blis catalogue confection cymem murmurhash preshed black yapf pydantic jinja2 langcodes murmurhash pathy filelock `
  imageio lazy_loader networkx pillow wrapt py moreutils pylint mypy pandas moviepy matplotlib `
  scipy seaborn skops scikit-learn scikit-image scikit-optimize box2d-py pybullet optuna cloudpickle plotly rliable `
  tensorflow tensorflow-addons[tensorflow] tensorboard TensorFlowTTS wandb chromadb pytablewriter pyyaml `
  torch torchvision torchaudio cython nltk poetry agents rl-agents span_marker speechbrain cataclysm `
  huggingface-hub huggingface_sb3 transformers diffusers adapter-transformers `
  sentence-transformers asteroid flair gensim spacy ml-agents espnet espnet2 fastchan fastai nemo_toolkit[all] `
  bertopic[test,docs,dev,flair,spacy,use,gensim,vision] dask paddlenlp pyannote-audio openai-whisper `
  nvtabular merlin-models merlin-systems merlin-dataloader merlin-sok transformers4rec[pytorch,nvtabular,docs,dev] `
  nvidia-cudnn-cu11 cudf-cu11 dask_cudf_cu11 cuml-cu11 cugraph-cu11 cucim nvidia-dali-cuda110 nvidia-dali-tf-plugin-cuda110 `
  tritonclient triton-model-analyzer nvidia-pytriton triton-model-navigator pyctcdecode pythae rl_zoo3 `
  jupyter-client jupyter-core jupyter jupyter-lsp jupyterlab jupyterlab-fonts jupyterlab-git jupyterlab-markup `
  jupyterlab_widgets jupyterlab-commands jupyterlab_code_formatter jupyterlab-black jupyterlab-requirements `
  jupyterlab-sparksql jupyterlab-drawio jupyterlab-powerpoint jupyterlab-github jupyterlab-flake8 jupyterlab-lsp `
  jupyterlab-graph-lsp jupyterlab-telemetry jupyterlab-kernelspy jupyterlab-system-monitor jupyterlab-topbar `
  jupyterlab-quickopen jupyter_contrib_core jupyter-contrib-nbextensions `
  stable-baselines3[extra,tests,docs] stable-baselines[mpi,tests,docs] sb3-contrib `
  gymnasium[accept-rom-license,all] gym[accept-rom-license,all] panda-gym gym-retro gym-super-mario-bros gym-minigrid flappy-bird-gymnasium `
  sample-factory[dev,atari,envpool,mujoco,vizdoom] trimm trimm-viz
  | Write-Host
spacy download en_core_web_sm | Write-Host
spacy download en_core_web_md | Write-Host
spacy download en_core_web_lg | Write-Host
spacy download en_core_web_trf | Write-Host
# TODO: https://github.com/NVIDIA/NeMo#nemo-megatron
