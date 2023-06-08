#!/usr/bin/env zsh
# shellcheck shell=bash
# init
set -e
os=$(uname -s)
# Setup pip
PYTHON_VERSION=$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
# shellcheck source=/dev/null
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export PIP_NO_CACHE_DIR=false'
if [ "$os" != "Linux" ]; then
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"\$HOME/Library/Python/$PYTHON_VERSION/bin:\$PATH\""
  # shellcheck source=/dev/null
  source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "export PATH=\"\$HOME/usr/local/opt/python@$PYTHON_VERSION/bin:\$PATH\""
fi

python -m ensurepip --upgrade
python -m pip install --no-input --upgrade pip setuptools wheel
if [ "$os" = "Linux" ]; then
  pip install --no-input --upgrade \
    nvidia-cudnn-cu11 cudf-cu11 dask_cudf_cu11 cuml-cu11 cugraph-cu11 cucim nvidia-dali-cuda110 nvidia-dali-tf-plugin-cuda110 \
    nvtabular "transformers4rec[pytorch,nvtabular,docs,dev]" triton-model-analyzer
  pip install --no-input --upgrade git+https://github.com/NVIDIA/TransformerEngine.git@stable
fi

python -m pip install --no-input --upgrade pygobject pycairo pipx virtualenv sphinx sphinx-multiversion \
  openvino onnxruntime Cython cataclysm

# https://huggingface.co/models?other=stable-baselines3
# https://github.com/DLR-RM/rl-trained-agents/tree/master
# https://github.com/facebookresearch/llama
# https://github.com/tatsu-lab/stanford_alpaca
# https://aka.ms/azsdk/python/all
# TODO: Check for Python 3.11 support:
#   cntk ml-agents espnet2 gym-retro fastchan TensorFlowTTS triton-model-navigator nvidia-pytriton trimm trimm-viz rliable
#   masl msal-extensions pytest-azurepipelines azureml-responsibleai azureml-dataprep-native azure-mlflow onnxruntime-extensions
#   torch-directml onnxruntime-silicon onnxruntime-openmp onnxruntime-directml onnxruntime-training onnxruntime-gpu
#   onnxruntime-cann onnxruntime-noopenmp onnxruntime-azure onnxruntime-openvino onnxruntime-coreml onnxruntime-powerpc64le
#   model-perf azure-ai-vision
# TODO: Keep a check on huggingface_sb3 it has huggingface-hub pinned to 0.8.1
# https://github.com/huggingface/huggingface_sb3/issues/27
# TODO: Keep a check on asteroid and see when it will allow upgrading torchmetrics>=0.11.0, currently torchmetrics<0.8.0
# https://github.com/asteroid-team/asteroid/issues/669
# TODO: Keep a check on pyannote-audio and see when it support more than pytorch-lightning<1.7 and >=1.5.4
# https://github.com/pyannote/pyannote-audio/issues/1396
# TODO: Keep a check on nemo-toolkit[asr] it will allow upgrading pytorch-lightning>=1.9.0,<=1.9.4 in the future
# TODO: Keep a check on rl-agents it only supports gym<0.18.0 and >=0.17.2
# TODO: Keep a check on gym-minigrid it only supports gym<=0.26 and >=0.22
# TODO: Keep a check on stable-baselines3[docs,extra,tests] 1.8.0 depends on gym==0.21
# TODO: Keep a check on dlltracer, it throws an error on install on Mac
# pytorch-lightning>=1.9.0,<=1.9.4
# gym[accept-rom-license,atari,box2d,classic_control,mujoco,robotics,toy_text,other]<=0.26,>=0.22
pip install --no-input --user --upgrade \
  platformdirs dill isort mccabe ipykernel ipython-genutils packaging docker-pycreds flask pathy numpy \
  pygments flake8 tqdm rich ruff pytest pytest-sugar pytest-cov pytest-xdist pytest-xprocess pytest-mock pytest-benchmark \
  autopep8 aiosqlite absl-py astunparse flatbuffers gast google-pasta grpcio h5py jax libclang opt-einsum protobuf \
  blis catalogue confection cymem murmurhash preshed black yapf pydantic jinja2 langcodes murmurhash filelock tokenizers \
  "openvino-dev[caffe,kaldi,mxnet,onnx,pytorch,tensorflow,tensorflow2]" openvino-workbench \
  mtcnn-onnxruntime onnxruntime-tools scikit-onnxruntime torch-ort torch-ort-infer \
  keras opencv-python imageio lazy_loader networkx pillow wrapt py moreutils pylint mypy pandas moviepy \
  matplotlib scipy seaborn "skops>=0.6.0" scikit-learn scikit-image scikit-optimize box2d-py pybullet "optuna>=3.2.0" \
  cloudpickle tensorflow "tensorflow-addons[tensorflow]" tensorboard "wandb>=0.15.3" chromadb pytablewriter pyyaml boto3 \
  plotly torch torchvision torchaudio fire "pytorch-lightning>==1.9.4" nltk poetry span_marker "speechbrain>=0.5.14" \
  "huggingface-hub>=0.15.1" "transformers>=4.29.2" "diffusers>=0.16.1" "adapter-transformers>=3.2.1" rouge_score \
  "sentence-transformers>=2.2.2" "flair>=0.12.2" gensim spacy "fastai>=2.7.12" "agents>=1.4.0" "lupyne[graphql,rest]" plush lucene-querybuilder \
  "nemo_toolkit[common,asr,nlp,tts,slu,test]>=1.18.0" "nemo_text_processing>=0.1.7rc0" shot-scraper \
  "bertopic[test,docs,dev,flair,spacy,use,gensim,vision]>=0.15.0" openai openai-whisper tiktoken ttok strip-tags llm llama-index \
  merlin-models merlin-systems merlin-dataloader merlin-sok fairscale sentencepiece langchain \
  "tritonclient>=2.34.0" pyctcdecode "pythae>=0.1.1" "rl_zoo3>=1.8.0" loralib "dask>=2023.5.1" \
  notebook jupyter-client jupyter-core jupyter jupyter-lsp jupyterlab jupyterlab-fonts jupyterlab-git jupyterlab-markup \
  jupyterlab_widgets jupyterlab-commands jupyterlab_code_formatter jupyterlab-black jupyterlab-requirements \
  jupyterlab-sparksql jupyterlab-drawio jupyterlab-powerpoint jupyterlab-github jupyterlab-flake8 jupyterlab-lsp \
  jupyterlab-graph-lsp jupyterlab-telemetry jupyterlab-kernelspy jupyterlab-system-monitor jupyterlab-topbar \
  jupyterlab-quickopen jupyter_contrib_core jupyter-contrib-nbextensions mlflow \
  "gymnasium[accept-rom-license,atari,box2d,classic-control,mujoco,mujoco-py,toy-text,jax,other,testing]" \
  panda-gym gym-super-mario-bros flappy-bird-gymnasium \
  "stable-baselines3[extra,tests,docs]>=1.8.0" "stable-baselines[mpi,tests,docs]" "sb3-contrib>=1.8.0" \
  "sample-factory[dev,atari,envpool,mujoco,vizdoom]" "espnet>=202304" "paddlenlp>=2.5.2" \
  azure-cli azure-identity azure-keyvault azure-cli-keyvault azure-keyvault-certificates azure-keyvault-secrets azure-keyvault-browser azure-keyvault-administration \
  azure_devtools azureml-dataprep semantic-kernel \
  batch-inference pytket pennylane qdk "azure-quantum[all]" quantum-viz knack qsharp qsharp-chemistry pytket-qsharp pennylane-qsharp \
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
  scenepic qiskit-qir azure-developer-loadtesting azure-defender-easm lsprotocol azure-appconfiguration keyper confidential-ml-utils \
  microsoft-bing-websearch microsoft-bing-spellcheck microsoft-bing-videosearch microsoft-bing-imagesearch \
  microsoft-bing-customimagesearch microsoft-bing-visualsearch microsoft-bing-entitysearch microsoft-bing-customwebsearch \
  microsoft-bing-newssearch microsoft-bing-autosuggest google google-cloud google-benchmark
files=("$HOME/.pip/pip.conf" "$HOME/.config/pip/pip.conf")
for file in "${files[@]}"; do
  if [ -e "$file" ]; then
    sed -i '.bak' '/no-cache-dir = .*/d' "$file" &>/dev/null
    echo "$file"
  fi
done

mkdir -p "$HOME/source/repos"
pushd "$HOME/source/repos"
rm -rf apex
git clone https://github.com/NVIDIA/apex.git
pushd apex
git checkout master
pip install --no-input --user -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" --global-option="--fast_layer_norm" --global-option="--distributed_adam" --global-option="--deprecated_fused_adam" ./
popd
popd
spacy download en_core_web_sm
spacy download en_core_web_md
spacy download en_core_web_lg
spacy download en_core_web_trf
# TODO: https://github.com/NVIDIA/NeMo#nemo-megatron
