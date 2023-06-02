Write-Host "setup/windows/pip.ps1"
python -m ensurepip --upgrade
python -m pip install --upgrade pip
pip install --upgrade --use-pep517 pip-review
pip install --upgrade py moreutils setuptools wheel pylint autopep8 black mypy flake8
pip install --upgrade pytest pytest-cov pytest-xdist pytest-html pytest-mock pytest-randomly pytest-sugar pytest-timeout pytest-asyncio pytest-asyncio-threading pytest-asyncio-network-simulator
pip install --upgrade jupyter jupyterlab jupyterlab-git jupyterlab-lsp jupyterlab_code_formatter jupyterlab_execute_time jupyterlab-kernelspy jupyterlab-system-monitor jupyterlab-topbar-extension
pip install --upgrade numpy pandas scipy matplotlib seaborn scikit-learn scikit-image cntk tensorflow keras torch torchvision transformers spacy nltk gensim opencv-python
pip-review --auto
