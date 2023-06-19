#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck source=/dev/null
set -euo pipefail
os=$(uname -s)
# Check fast level
devspace=devspace
if [[ "${PYENV_VERSION:-}" == "$devspace" ]]; then
  export PIP_FAST_LEVEL=${PIP_FAST_LEVEL:-${FAST_LEVEL:-0}}
else
  export PIP_FAST_LEVEL=0
fi

echo "PIP_FAST_LEVEL=$PIP_FAST_LEVEL"
# https://huggingface.co/models?other=stable-baselines3
# https://github.com/DLR-RM/rl-trained-agents/tree/master
# https://github.com/facebookresearch/llama
# https://github.com/tatsu-lab/stanford_alpaca
# https://aka.ms/azsdk/python/all
# TODO: Needs Python 3.9: merlin-sok merlin-dataloader merlin-systems fairscale azure-keyvault azure-identity
#       azure-cli azure-cli-keyvault torch-ort
# TODO: Check for Python 3.11 support:
#   cntk ml-agents espnet2 gym-retro fastchan TensorFlowTTS triton-model-navigator nvidia-pytriton trimm trimm-viz rliable
#   msal msal-extensions pytest-azurepipelines azureml-responsibleai azureml-dataprep-native azure-mlflow
#   torch-directml model-perf azure-ai-vision
# TODO: 'botbuilder-dialogs>=4.14.4'
# TODO: Keep a check on huggingface-sb3 it has huggingface-hub pinned to 0.8.1
# TODO: Check onnxruntime-openmp onnxruntime-noopenmp onnxruntime-coreml onnxruntime-silicon onnxruntime-gpu onnxruntime-cann onnxruntime-azure onnxruntime-powerpc64le
# https://github.com/huggingface/huggingface_sb3/issues/27
# TODO: Keep a check on asteroid and see when it will allow upgrading torchmetrics>=0.11.0, currently torchmetrics<0.8.0
# https://github.com/asteroid-team/asteroid/issues/669
# TODO: Keep a check on pyannote-audio and see when it support more than pytorch-lightning<1.7 and >=1.5.4
# https://github.com/pyannote/pyannote-audio/issues/1396
# TODO: Keep a check on nemo-toolkit[asr] it will allow upgrading pytorch-lightning>=1.9.0,<=1.9.4 in the future
# TODO: Keep a check on rl-agents it only supports gym<0.18.0 and >=0.17.2
# TODO: Keep a check on gym-minigrid it only supports gym<=0.26 and >=0.22
# TODO: Keep a check on sb3-contrib stable-baselines3[docs,extra,tests] 1.8.0 depends on gym==0.21
# TODO: Needs gym, 'rl-zoo3[plots]>=1.8.0'
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
#       jupyterlab-quickopen
# TODO: 'gymnasium[accept-rom-license,atari,box2d,classic-control,mujoco,mujoco-py,toy-text,jax,other,testing]>=0.28.1' needs scipy>=1.7.1
#       panda-gym gym-super-mario-bros flappy-bird-gymnasium
# TODO: nemo-toolkit[asr,common,nlp,slu,test,tts] 1.18.1 depends on pytorch-lightning<=1.9.4 and >=1.9.0; extra == "nlp" pytorch-lightning>=1.9.0,<=1.9.4
# gym[accept-rom-license,atari,box2d,classic_control,mujoco,robotics,toy_text,other]<=0.26,>=0.22
# TODO: transformers4rec[docs,dev] https://github.com/NVIDIA-Merlin/Transformers4Rec
# TODO: 'sample-factory[dev,atari,envpool,mujoco,vizdoom]>=2.0.3'
# TODO: semantic-kernel, onefuzz, espnet, dbt_core, dbt-glue, presidio-image-redactor, cataclysm, timm-viz,ptgnn, botbuilder-azure
# TODO: olive-ai, textworld, deepgnn-ge, azure-ai-translation-text
# TODO: Fix grep: Unmatched [, [^, [:, [., or [=
# TODO: 'msticpy[azure]==2.3.1' 'msticnb>=1.1.0'
# Setup pip
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'export PYENV_VIRTUALENV_DISABLE_PROMPT=1'
# Array of Python versions to upgrade
# Array of Python versions to upgrade
versions=("3.9" "3.10" "3.11")
for version in "${versions[@]}"; do
  # Find the highest installed version and the highest available version
  installed_version=$(pyenv versions --bare | { grep -oP "$version\.\d+" || true; } | sort -V | tail -n 1)
  latest_version=$(pyenv install --list | grep -oP "$version\.\d+" | sort -V | tail -n 1)

  # If the installed version is not the latest version, uninstall it and install the latest version
  if [[ "$installed_version" != "$latest_version" ]]; then
    if [[ -n "$installed_version" ]]; then
      pyenv uninstall -f "$installed_version"
    fi

    pyenv install "$latest_version"
  fi
done

# Function to clone or update a repo
function clone_or_update_repo() {
  local repo_name="$1"
  local repo_owner="$2"
  local repo_cmd="${3:-}"
  local repo_dir="$HOME/.pip/repos/$repo_name"

  "$DEVCONTAINER_SCRIPTS_ROOT/utils/clone-or-update-repo.sh" "$repo_name" "$repo_owner" "$repo_dir" "$repo_cmd"
}

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
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" 'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi'
source "$DEVCONTAINER_SCRIPTS_ROOT/utils/updaterc.sh" "if [[ \"\$PYENV_VERSION\" != \"$devspace\" ]]; then pyenv activate \"$devspace\"; fi"
python --version
python -m ensurepip --upgrade
python -m pip install --no-input --upgrade pip
pip --version
"$DEVCONTAINER_SCRIPTS_ROOT/utils/pip-enable-cache.sh"
packages=('setuptools==65.5.1' wheel 'cython>=0.29.35' pygobject pycairo pipx virtualenv pyyaml pybind11 libclang clang-format clang-tidy
  sphinx sphinx-multiversion enchant 'numpy==1.23.4' 'networkx>=2.8,<=2.8.8')
if [ "$os" = "Linux" ]; then
  packages+=(nvidia-cudnn-cu11 cudf-cu11 dask-cudf-cu11 cuml-cu11 cugraph-cu11 cucim nvidia-dali-cuda110 nvidia-dali-tf-plugin-cuda110
    triton-model-analyzer onnxruntime-training
    'pennylane-lightning[gpu]' qulacs-gpu nvtabular 'transformers4rec[pytorch,nvtabular]' merlin-core merlin-models merlin-dataloader)
else
  packages+=(keyper)
fi

# # shellcheck disable=SC2016
# clone_or_update_repo openvino openvinotoolkit 'mkdir -p build && pushd build; cmake -G "Ninja Multi-Config" -DENABLE_SYSTEM_PUGIXML=ON -DENABLE_SYSTEM_SNAPPY=ON -DENABLE_SYSTEM_PROTOBUF=ON -DENABLE_PYTHON=ON -DProtobuf_INCLUDE_DIR="$HOMEBREW_PREFIX/opt/protobuf/include" -DProtobuf_LIBRARY="$HOMEBREW_PREFIX/opt/protobuf/lib" -DOpenMP_C_FLAGS="-fopenmp -I$HOMEBREW_PREFIX/opt/libomp/include" -DOpenMP_C_LIB_NAMES="gomp" -DOpenMP_gomp_LIBRARY="$HOMEBREW_PREFIX/opt/gcc/lib/gcc/current/libgomp.dylib" ..; cmake --build . --config Release --parallel $(sysctl -n hw.ncpu); popd;'
packages+=(platformdirs isort mccabe ipykernel ipython-genutils packaging nbmake absl-extra docker-pycreds 'flask==2.2.5' 'poetry>=1.5.1' pathy playwright
  ninja tbb pugixml flatbuffers snappy zlib-ng absl-py libusb
  pygments flake8 tqdm rich ruff lit pytest pytest-sugar pytest-cov pytest-xdist pytest-xprocess pytest-mock pytest-benchmark pytest-playwright
  autopep8 aiosqlite absl-py astunparse google-pasta grpcio 'h5py>=3.8.0' 'knack>=0.10.1'
  'blis<0.8.0,>=0.7.8' catalogue confection cymem murmurhash preshed yapf pydantic jinja2 langcodes murmurhash filelock
  'dask>=2023.5.1' 'shot-scraper>=1.2' strip-tags 'pynini>0.1.1' lsprotocol debugpy
  tokenizers sentencepiece lazy-loader pillow py 'pylint[spelling]>=2.17.4' mypy 'pandas>=2.0.2' 'moviepy>=1.0.3' 'opt-einsum>=3.3.0'
  'jsmin>=3.0.1' msal msal-extensions 'chromadb>=0.3.26' pytablewriter boto3 cloudpickle 'scenepic>=1.1.0'
  'opencv-python>=4.7.0.72' 'imageio>=2.31.1' 'matplotlib==3.6.2' plotly 'scipy>=1.10.1' 'seaborn>=0.12.2' 'spacy>=3.5.3' 'nltk>=3.8.1' 'rouge-score>=0.1.2' 'gensim>=4.3.1'
  'pyctcdecode>=0.5.0' 'lupyne[graphql,rest]' plush lucene-querybuilder intel-openmp
  'jax>=0.4.12' 'jaxlib>=0.4.12' 'autograd>=1.5' autograd-minimize box2d-py pybullet 'optuna>=3.2.0'
  'scikit-learn>=1.2.2' 'scikit-image>=0.21.0' 'scikit-optimize>=0.9.0'
  'tensorflow>=2.12.0' 'tensorflow-addons[tensorflow]' tensorboard keras batch-inference 'gast<=0.4.0,>=0.2.1' 'wrapt<1.15,>=1.11.0' 'protobuf<4,>=3.8.0' 'wandb>=0.15.3'
  kaggle fastkaggle pipdeptree
  'torch>=2.0.1' torchvision torchaudio fire 'pytorch-lightning==1.9.4' timm 'torchmetrics'
  'speechbrain>=0.5.14' 'flair>=0.12.2' 'fastai[dev]>=2.7.12' 'fastai-datasets>=0.0.8'
  'accelerate>=0.20.3' 'transformers>=4.30.2' 'datasets>=2.13.0' 'diffusers>=0.16.1' 'adapter-transformers>=3.2.1' 'span-marker>=1.1.1' 'sentence-transformers>=2.2.2'
  openai 'openai-whisper>=20230314' 'tiktoken==0.3.1' ttok llm llama-index loralib 'langchain>=0.0.202'
  'pythae>=0.1.1' 'paddlenlp>=2.5.2' 'altair>=5.0.1' 'dill<0.3.5'
  'nemo-toolkit[common,asr,nlp,tts,slu,test]>=1.19.0' 'nemo-text-processing>=0.1.7rc0'
  'bertopic[test,docs,dev,flair,spacy,use,gensim,vision]>=0.15.0'
  'tritonclient>=2.34.0'
  azure-devtools azure-keyvault-certificates azure-keyvault-secrets azure-keyvault-administration 'azureml-dataprep>=4.11.3'
  'presidio-cli>=0.0.8' 'presidio-analyzer>=2.2.33' presidio-anonymizer presidio-evaluator
  botbuilder-ai botbuilder-applicationinsights botbuilder-core 'botbuilder-schema>=4.14.4' 'botframework-connector>=4.14.4'
  'bokeh<3.0.0,>=1.4.0' 'gradio>=3.28.3' 'mdit-py-plugins==0.3.3'
  sympy 'deepgnn-torch>=0.1.60' deepgnn-tf graphviz
  graspologic azure-cosmos 'msrest==0.6.*' import-mocker 'streamlit>=1.23.1'
  'azure-ai-ml>=1.8.0' azure-ai-contentsafety azure-ai-mlmonitoring azure-ai-textanalytics 'azure-ai-formrecognizer>=3.2.1'
  azure-ai-anomalydetector azure-ai-metricsadvisor azureml-rai-utils azure-ai-translation-document
  azure-ai-language-questionanswering azure-ai-language-conversations azure-cli-cognitiveservices azure-cognitiveservices-speech
  azure-cognitiveservices-inkrecognizer azure-cognitiveservices-personalizer azure-cognitiveservices-anomalydetector
  azure-cognitiveservices-vision-computervision azure-cognitiveservices-vision-customvision azure-cognitiveservices-knowledge-qnamaker
  azure-cognitiveservices-language-luis azure-cognitiveservices-vision-contentmoderator 'azure-cognitiveservices-search-websearch>=2.0.0'
  azure-cognitiveservices-search-videosearch 'azure-cognitiveservices-search-visualsearch>=0.2.0' 'azure-cognitiveservices-vision-face>=0.6.0'
  azure-cognitiveservices-search-autosuggest 'azure-cognitiveservices-search-imagesearch>=2.0.0'
  azure-cognitiveservices-search-newssearch 'azure-cognitiveservices-search-customsearch>=0.3.0' azure-cognitiveservices-search-customimagesearch
  'azure-cognitiveservices-search-entitysearch>=2.0.0' planetary-computer azure-pylint-guidelines-checker
  azure-developer-loadtesting azure-defender-easm azure-appconfiguration confidential-ml-utils
  microsoft-bing-websearch microsoft-bing-spellcheck microsoft-bing-videosearch microsoft-bing-imagesearch
  microsoft-bing-customimagesearch microsoft-bing-visualsearch microsoft-bing-entitysearch microsoft-bing-customwebsearch
  microsoft-bing-newssearch microsoft-bing-autosuggest google google-cloud google-benchmark
  'iqm-client>=12.5' "cirq~=1.1" 'cirq-iqm>=11.9' quil 'pyquil>=3.5.4' qclient 'qulacs>=0.6.0' 'qulacsvis>=0.7.1'
  qiskit-terra qiskit-ibmq-provider 'qiskit[visualization,experiments,optimization,finance,machine-learning,nature]' qiskit-qir
  qdk qsharp qsharp-chemistry 'azure-quantum[dev,cirq,qiskit,qsharp,quil]>=0.28.277227' pyquil-for-azure-quantum quantum-viz
  'pytket>=1.16.0' 'pennylane>=0.30.0' pennylane-lightning
  pytket-cirq pytket-iqm pytket-qir pytket-qsharp pytket-qulacs 'pytket-pennylane>=0.8.0'
  pennyLane-cirq pennyLane-qiskit pennylane-qulacs pennylane-qsharp
  'black[jupyter]' jupyter-client jupyter-core notebook notebook2script jupyterlab voila jupyter-contrib-core jupyter-contrib-nbextensions nbdev RISE 'mlflow>2.4.0'
  'huggingface-hub>=0.15.1' 'skops>=0.6.0' openvino openvino-dev rapidocr-openvino
  onnxruntime onnxruntime-extensions onnxruntime-tools mtcnn-onnxruntime
  'scikit-onnxruntime>=0.2.1.4' torch-ort-inference 'torch-ort-infer>=1.13.1' rapidocr-onnxruntime)
pip install --no-input --upgrade "${packages[@]}"
if [ "$os" = "Linux" ]; then
  pip install --no-input --upgrade --global-option="--cpp_ext" --global-option="--cuda_ext" --global-option="--fast_layer_norm" \
    --global-option="--distributed_adam" --global-option="--deprecated_fused_adam" \
    'git+https://github.com/NVIDIA/TransformerEngine.git@stable' 'git+https://github.com/NVIDIA/apex.git'
fi

# Setup catalyst
clone_or_update_repo catalyst PennyLaneAI 'python setup.py install'
# Setup onnxruntime and openvino
# shellcheck disable=SC2016
clone_or_update_repo onnxruntime microsoft 'NVCC_OUT=/tmp ./build.sh --config Release --skip_tests --skip-keras-test --ms_experimental --build_wheel --enable_pybind  --use_gdk --use_full_protobuf --enable_lto --enable_multi_device_test --use_xcode --enable_memory_profile --enable_training --enable_training_apis --enable_training_ops --mpi_home "$$HOMEBREW_PREFIX/open-mpi" --use_mpi true --enable_lazy_tensor --use_cache --use_lock_free_queue --use_coreml --use_openvino CPU_FP32 --build_wasm --enable_wasm_simd --enable_wasm_threads --enable_wasm_api_exception_catching --enable_wasm_exception_throwing_override --enable_wasm_profiling --enable_wasm_debug_info --wasm_run_tests_in_browser --use_azure --build_shared_lib --build_apple_framework --build_wasm_static_lib  --use_extensions --parallel --llvm_path "$HOMEBREW_PREFIX/opt/llvm"'
# shellcheck disable=SC2154
pip install --no-input --upgrade "$onnxruntime/build/Linux/Release/dist/onnxruntime_openvino-*.whl"
spacy download en_core_web_sm
spacy download en_core_web_md
spacy download en_core_web_lg
spacy download en_core_web_trf
# TODO: https://github.com/NVIDIA/NeMo#nemo-megatron
