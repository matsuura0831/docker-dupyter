ARG BASE_MODE="cpu"
FROM matsuura0831/dupyter:${BASE_MODE}-latest

ARG PYTHON_VERSION="3.6"

ADD base.requirements.txt /base.requirements.txt
ADD tf.requirements.txt.${BASE_MODE} /tf.requirements.txt
ADD keras.requirements.txt.${BASE_MODE} /keras.requirements.txt
ADD pytorch.requirements.txt.${BASE_MODE} /pytorch.requirements.txt

RUN apt-get update && \
  apt-get install -y graphviz && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# install anaconda and jupyter library
RUN eval "$(pyenv init -)" && \
  conda create -y -n tf python=${PYTHON_VERSION} anaconda && \
  pyenv activate tf && \
    pip install --upgrade pip && \
    pip install -r /base.requirements.txt && \
    pip install -r /tf.requirements.txt

RUN eval "$(pyenv init -)" && \
  conda create -y -n keras --clone tf && \
  pyenv activate keras && \
    pip install -r /keras.requirements.txt

RUN eval "$(pyenv init -)" && \
  conda create -y -n pytorch python=${PYTHON_VERSION} anaconda && \
  pyenv activate pytorch && \
    pip install --upgrade pip && \
    pip install -r /base.requirements.txt && \
    pip install -r /pytorch.requirements.txt
