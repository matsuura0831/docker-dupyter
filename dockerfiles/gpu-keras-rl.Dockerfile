FROM matsuura0831/dupyter:gpu-keras

ADD rl.requirements.txt /

# install anaconda and jupyter library
RUN eval "$(pyenv init -)" && \
  conda create -y -n keras-rl --clone keras && \
  pyenv activate keras-rl && \
    pip install --upgrade pip && \
    pip install -r /rl.requirements.txt && \
  pyenv deactivate
