FROM matsuura0831/dupyter:dnn

ADD rl.requirements.txt /

RUN eval "$(pyenv init -)" && \
  pyenv activate tf && \
    pip install -r /rl.requirements.txt && \
  pyenv activate keras && \
    pip install -r /rl.requirements.txt && \
  pyenv activate pytouch && \
    pip install -r /rl.requirements.txt && \
  pyenv deactivate

