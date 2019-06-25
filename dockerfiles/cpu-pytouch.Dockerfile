FROM matsuura0831/dupyter:cpu

# install anaconda and jupyter library
RUN eval "$(pyenv init -)" && \
  conda create -y -n pytouch python=3.7 anaconda && \
  pyenv activate pytouch && \
    pip install --upgrade pip && \
    pip install https://download.pytorch.org/whl/cpu/torch-1.1.0-cp37-cp37m-linux_x86_64.whl && \
    pip install https://download.pytorch.org/whl/cpu/torchvision-0.3.0-cp37-cp37m-linux_x86_64.whl && \
  pyenv deactivate
