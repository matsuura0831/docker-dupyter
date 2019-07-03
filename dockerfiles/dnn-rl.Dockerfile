ARG BASE_MODE="cpu"
FROM matsuura0831/dupyter:${BASE_MODE}-dnn

ADD rl.requirements.txt /

RUN eval "$(pyenv init -)" && \
  pyenv activate tf && \
    pip install -r /rl.requirements.txt && \
  pyenv activate keras && \
    pip install -r /rl.requirements.txt && \
  pyenv activate pytorch && \
    pip install -r /rl.requirements.txt && \
  pyenv deactivate

