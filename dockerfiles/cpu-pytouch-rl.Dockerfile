FROM matsuura0831/dupyter:cpu-pytouch

ADD rl.requirements.txt /

# install anaconda and jupyter library
RUN eval "$(pyenv init -)" && \
  conda create -y -n pytouch-rl --clone pytouch && \
  pyenv activate pytouch-rl && \
    pip install --upgrade pip && \
    pip install -r /rl.requirements.txt && \
  pyenv deactivate
