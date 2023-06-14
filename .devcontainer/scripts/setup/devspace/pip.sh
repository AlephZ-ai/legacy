#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
# init
set -euo pipefail
os=$(uname -s)
# Setup pip
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1'
# Check fast level
devspace=devspace
if [[ "${PYENV_VERSION:-}" != "$devspace" ]]; then
  export PIP_FAST_LEVEL=${PIP_FAST_LEVEL:-${FAST_LEVEL:-0}}
else
  export PIP_FAST_LEVEL=0
fi

echo "PIP_FAST_LEVEL=$PIP_FAST_LEVEL"
# Array of Python versions to upgrade
versions=("3.9" "3.10" "3.11")
for version in "${versions[@]}"; do
  # Find the highest installed version and the highest available version
  installed_version=$(pyenv versions --bare | { grep -oP "$version\.\d+" || true; } | sort -V | tail -n 1)
  latest_version=$(pyenv install --list | grep -oP "$version\.\d+" | sort -V | tail -n 1)
  echo "Installed version: $installed_version"
  echo "Latest version: $latest_version"
  # If the installed version is not the latest version, uninstall it and install the latest version
  if [[ "$installed_version" != "$latest_version" ]]; then
    if [[ -n "$installed_version" ]]; then
      pyenv uninstall -f "$installed_version"
    fi

    pyenv install "$latest_version"
  fi
done

globalVersion=$(pyenv versions --bare | grep -oP "3.11\.\d+" | sort -V | tail -n 1)
expectedVersion=$(pyenv versions --bare | grep -oP "3.10\.\d+" | sort -V | tail -n 1)
devspaceExists=$(pyenv virtualenvs --bare | grep -qoP "^$devspace\$" &>/dev/null && echo true || echo false)
pyenv global "$globalVersion"
if $devspaceExists; then
  devspaceVersion="$("$(pyenv root)/versions/$devspace/bin/python" --version 2>&1 | cut -d ' ' -f 2)"
  if [[ "$devspaceVersion" != "$expectedVersion" ]]; then
    pyenv virtualenv-delete -f "$devspace"
    devspaceExists=false
  fi
fi

if ! $devspaceExists; then
  pyenv virtualenv "$expectedVersion" "$devspace"
fi

# shellcheck disable=SC2016
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi'
# shellcheck disable=SC2016
ource "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi'
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "if [[ \"\$PYENV_VERSION\" != \"$devspace\" ]]; then pyenv activate \"$devspace\"; fi"
python --version
python -m ensurepip --upgrade
python -m pip install --no-input --upgrade pip setuptools wheel
pip --version
if [ "$os" = "Linux" ]; then
  pip install --no-input --upgrade --global-option="--cpp_ext" --global-option="--cuda_ext" --global-option="--fast_layer_norm" --global-option="--distributed_adam" --global-option="--deprecated_fused_adam" \
    nvidia-cudnn-cu11 cudf-cu11 dask-cudf-cu11 cuml-cu11 cugraph-cu11 cucim nvidia-dali-cuda110 nvidia-dali-tf-plugin-cuda110 \
    triton-model-analyzer onnxruntime-training git+https://github.com/NVIDIA/TransformerEngine.git@stable git+https://github.com/NVIDIA/apex.git \
    torch-ort torch-ort-inference torch-ort-infer pennylane-lightning[gpu] qulacs-gpu
fi

# https://huggingface.co/models?other=stable-baselines3
# https://github.com/DLR-RM/rl-trained-agents/tree/master
# https://github.com/facebookresearch/llama
# https://github.com/tatsu-lab/stanford_alpaca
# https://aka.ms/azsdk/python/all
# TODO: Needs Python 3.9: merlin-sok merlin-dataloader merlin-systems fairscale azure-keyvault azure-identity
#       azure-cli azure-cli-keyvault
# TODO: Check for Python 3.11 support:
#   cntk ml-agents espnet2 gym-retro fastchan TensorFlowTTS triton-model-navigator nvidia-pytriton trimm trimm-viz rliable
#   msal msal-extensions pytest-azurepipelines azureml-responsibleai azureml-dataprep-native azure-mlflow
#   torch-directml onnxruntime-silicon onnxruntime-openmp onnxruntime-directml onnxruntime-gpu
#   onnxruntime-cann onnxruntime-noopenmp onnxruntime-azure onnxruntime-openvino onnxruntime-coreml onnxruntime-powerpc64le
#   model-perf azure-ai-vision
# TODO: Keep a check on huggingface-sb3 it has huggingface-hub pinned to 0.8.1
# https://github.com/huggingface/huggingface_sb3/issues/27
# TODO: Keep a check on asteroid and see when it will allow upgrading torchmetrics>=0.11.0, currently torchmetrics<0.8.0
# https://github.com/asteroid-team/asteroid/issues/669
# TODO: Keep a check on pyannote-audio and see when it support more than pytorch-lightning<1.7 and >=1.5.4
# https://github.com/pyannote/pyannote-audio/issues/1396
# TODO: Keep a check on nemo-toolkit[asr] it will allow upgrading pytorch-lightning>=1.9.0,<=1.9.4 in the future
# TODO: Keep a check on rl-agents it only supports gym<0.18.0 and >=0.17.2
# TODO: Keep a check on gym-minigrid it only supports gym<=0.26 and >=0.22
# TODO: Keep a check on sb3-contrib stable-baselines3[docs,extra,tests] 1.8.0 depends on gym==0.21
# TODO: Old? stable-baselines[mpi,tests,docs]
# TODO: Keep a check on dlltracer, it throws an error on install on Mac
# TODO: openvino-dev[caffe,kaldi,mxnet,onnx,pytorch,tensorflow,tensorflow2]
# TODO: openvino-workbench 2022.3.0 depends on requests==2.22.0
# TODO: agents depends on gym==0.21.0 and that gym breaks with:
#       error in gym setup command: 'extras_require' must be a dictionary whose values are strings or lists of strings containing valid project/version requirement specifiers.
# TODO: Real old jupyter "jupyter-lsp>4.2.0" "jupyterlab>=4.0.2" jupyterlab-fonts "jupyterlab-git>=0.41.0" jupyterlab-markup
#       jupyterlab-widgets jupyterlab-commands "jupyterlab-code-formatter>=2.2.1" jupyterlab-black jupyterlab-requirements
#       jupyterlab-sparksql jupyterlab-drawio jupyterlab-powerpoint jupyterlab-github jupyterlab-flake8 jupyterlab-lsp
#       jupyterlab-graph-lsp jupyterlab-telemetry jupyterlab-kernelspy jupyterlab-system-monitor jupyterlab-topbar
#       jupyterlab-quickopen jupyter-contrib-core jupyter-contrib-nbextensions
# TODO: 'gymnasium[accept-rom-license,atari,box2d,classic-control,mujoco,mujoco-py,toy-text,jax,other,testing]>=0.28.1' needs scipy>=1.7.1
#       panda-gym gym-super-mario-bros flappy-bird-gymnasium
# TODO: nemo-toolkit[asr,common,nlp,slu,test,tts] 1.18.1 depends on pytorch-lightning<=1.9.4 and >=1.9.0; extra == "nlp" pytorch-lightning>=1.9.0,<=1.9.4
# gym[accept-rom-license,atari,box2d,classic_control,mujoco,robotics,toy_text,other]<=0.26,>=0.22
# TODO: transformers4rec[docs,dev] https://github.com/NVIDIA-Merlin/Transformers4Rec
# TODO: 'sample-factory[dev,atari,envpool,mujoco,vizdoom]>=2.0.3'
# TODO: Fix grep: Unmatched [, [^, [:, [., or [=
catalyst="$HOME/source/repos/catalyst"
catalyst_ver=$(curl --silent "https://api.github.com/repos/PennyLaneAI/catalyst/tags" | jq -r '.[0].name')
mkdir -p "$catalyst"
git clone https://github.com/PennyLaneAI/catalyst.git "$catalyst" &>/dev/null || true
pushd "$catalyst"
git checkout "$catalyst_ver"
git submodule update --init --recursive
# shellcheck disable=SC2016
git submodule foreach --recursive 'git config pull.rebase true; branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git checkout --theirs "$branch"; git pull origin "$branch"'
popd
pip install --no-input --upgrade setuptools wheel pygobject pycairo pipx virtualenv sphinx sphinx-multiversion \
  openvino onnxruntime onnxruntime-extensions cataclysm 'Cython>=0.29.35' \
  platformdirs dill isort mccabe ipykernel ipython-genutils packaging docker-pycreds flask pathy tbb 'pynini>0.1.1' \
  pygments flake8 tqdm rich ruff pytest pytest-sugar pytest-cov pytest-xdist pytest-xprocess pytest-mock pytest-benchmark \
  autopep8 aiosqlite absl-py astunparse flatbuffers gast google-pasta grpcio h5py jax jaxlib libclang opt-einsum protobuf \
  'blis>=0.9.1' catalogue confection cymem murmurhash preshed black yapf pydantic jinja2 langcodes murmurhash filelock tokenizers \
  msal msal-extensions numpy 'jsmin>=3.0.1' 'opt-einsum>=3.3.0' 'openvino-dev>=2023.0.0' \
  mtcnn-onnxruntime onnxruntime-tools scikit-onnxruntime 'autograd>=1.5' autograd-minimize \
  'semantic-kernel>=0.3.1.dev0' batch-inference 'pytket>=1.16.0' 'pennylane>=0.30.0' 'pytket-pennylane>=0.8.0' pennylane-lightning "$catalyst" qulacs pennylane-qulacs pytket-qulacs qulacsvis \
  keras opencv-python imageio lazy-loader networkx pillow wrapt py moreutils pylint mypy pandas moviepy \
  matplotlib 'scipy<2' seaborn 'skops>=0.6.0' 'scikit-learn>=1.2.2' 'scikit-image>=0.21.0' 'scikit-optimize>=0.9.0' box2d-py pybullet 'optuna>=3.2.0' \
  cloudpickle tensorflow 'tensorflow-addons[tensorflow]' tensorboard 'wandb>=0.15.3' chromadb pytablewriter pyyaml boto3 \
  plotly torch torchvision torchaudio fire 'pytorch-lightning<=1.9.4,>=1.9.0' nltk poetry 'span-marker>=1.1.1' 'speechbrain>=0.5.14' \
  'huggingface-hub>=0.15.1' 'transformers>=4.29.2' 'diffusers>=0.16.1' 'adapter-transformers>=3.2.1' rouge-score \
  'sentence-transformers>=2.2.2' 'flair>=0.12.2' 'gensim>=4.3.1' spacy 'fastai>=2.7.12' 'lupyne[graphql,rest]' plush lucene-querybuilder \
  'nemo-toolkit[common,asr,nlp,tts,slu,test]>=1.18.0' 'nemo-text-processing>=0.1.7rc0' shot-scraper \
  'bertopic[test,docs,dev,flair,spacy,use,gensim,vision]>=0.15.0' openai 'openai-whisper>=20230314' tiktoken ttok strip-tags llm llama-index \
  nvtabular 'transformers4rec[pytorch,nvtabular]>=23.5.0' merlin-models sentencepiece langchain \
  'tritonclient>=2.34.0' pyctcdecode 'pythae>=0.1.1' 'rl-zoo3>=1.8.0' loralib 'dask>=2023.5.1' \
  notebook jupyter-client jupyter-core 'mlflow>2.4.0' \
  'espnet>=202304' 'paddlenlp>=2.5.2' \
  azure-keyvault-certificates azure-keyvault-secrets azure-keyvault-browser azure-keyvault-administration \
  azure-devtools azureml-dataprep cirq cirq-iqm pennyLane-cirq quil pyquil qclient \
  qiskit-terra qiskit-ibmq-provider 'qiskit[visualization,experiments,optimization,finance,machine-learning,nature]' qiskit-qir pennyLane-qiskit \
  qdk knack qsharp qsharp-chemistry pytket-qsharp pennylane-qsharp 'azure-quantum[dev,cirq,qiskit,qsharp,quil]' pyquil-for-azure-quantum quantum-viz \
  presidio-cli presidio-analyzer presidio-anonymizer presidio-evaluator presidio-image-redactor msticpy msticnb \
  textworld botbuilder-ai botbuilder-applicationinsights botbuilder-azure botbuilder-core botbuilder-dialogs botbuilder-schema botframework-connector \
  onefuzz ptgnn deepgnn-ge deepgnn-torch deepgnn-tf rapidocr-openvino rapidocr-onnxruntime \
  graspologic olive-ai azure-cosmos msrest import-mocker \
  azure-ai-ml azure-ai-contentsafety azure-ai-mlmonitoring azure-ai-textanalytics azure-ai-formrecognizer \
  azure-ai-anomalydetector azure-ai-metricsadvisor azureml-rai-utils azure-ai-translation-text azure-ai-translation-document \
  azure-ai-language-questionanswering azure-ai-language-conversations azure-cli-cognitiveservices azure-cognitiveservices-speech \
  azure-cognitiveservices-inkrecognizer azure-cognitiveservices-personalizer azure-cognitiveservices-anomalydetector \
  azure-cognitiveservices-vision-computervision azure-cognitiveservices-vision-customvision azure-cognitiveservices-knowledge-qnamaker \
  azure-cognitiveservices-language-luis azure-cognitiveservices-vision-contentmoderator azure-cognitiveservices-search-websearch \
  azure-cognitiveservices-search-videosearch azure-cognitiveservices-search-visualsearch azure-cognitiveservices-vision-face \
  azure-cognitiveservices-search-autosuggest azure-cognitiveservices-search-imagesearch azure-cognitiveservices-language-spellcheck \
  azure-cognitiveservices-search-newssearch azure-cognitiveservices-search-customsearch azure-cognitiveservices-search-customimagesearch \
  azure-cognitiveservices-search-entitysearch playwright pytest-playwright planetary-computer debugpy azure-pylint-guidelines-checker \
  scenepic azure-developer-loadtesting azure-defender-easm lsprotocol azure-appconfiguration keyper confidential-ml-utils \
  microsoft-bing-websearch microsoft-bing-spellcheck microsoft-bing-videosearch microsoft-bing-imagesearch \
  microsoft-bing-customimagesearch microsoft-bing-visualsearch microsoft-bing-entitysearch microsoft-bing-customwebsearch \
  microsoft-bing-newssearch microsoft-bing-autosuggest google google-cloud google-benchmark
"$DEVCONTAINER_SCRIPTS_ROOT/utils/pip-enable-cache.sh"
spacy download en_core_web_sm
spacy download en_core_web_md
spacy download en_core_web_lg
spacy download en_core_web_trf
# TODO: https://github.com/NVIDIA/NeMo#nemo-megatron
