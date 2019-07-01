ARG PYTHON_VERSION=3.6
FROM matsuura0831/dupyter:latest

ADD base.requirements.txt /
ADD keras.requirements.txt /

RUN apt-get update && \
  apt-get install -y graphviz && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# install anaconda and jupyter library
RUN eval "$(pyenv init -)" && \
  conda create -y -n tf python=${PYTHON_VERSION} anaconda && \
  pyenv activate tf && \
    pip install --upgrade pip && \
    pip install tensorflow && \
    pip install -r /base.requirements.txt  && \
  pyenv deactivate && \
  conda create -y -n keras --clone tf && \
  pyenv activate keras && \
    pip install -r /keras.requirements.txt && \
  pyenv deactivate && \
  conda create -y -n pytouch python=${PYTHON_VERSION} anaconda && \
  pyenv activate pytouch && \
    pip install --upgrade pip && \
    pip install https://download.pytorch.org/whl/cpu/torch-1.1.0-cp37-cp37m-linux_x86_64.whl && \
    pip install https://download.pytorch.org/whl/cpu/torchvision-0.3.0-cp37-cp37m-linux_x86_64.whl && \
    pip install -r /base.requirements.txt  && \
  pyenv deactivate
