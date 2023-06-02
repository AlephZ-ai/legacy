Write-Host "setup/windows/pip.ps1"
python -m ensurepip --upgrade
python -m pip install --upgrade pip
pip install --upgrade --use-pep517 pip-review
pip install --upgrade wheel py moreutils setuptools pylint autopep8 black mypy flake8 `
  numpy pandas scipy matplotlib seaborn scikit-learn scikit-image tensorflow keras `
  torch torchvision transformers jupyter spacy nltk gensim opencv-python
pip-review --auto
