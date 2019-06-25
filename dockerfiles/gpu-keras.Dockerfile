FROM matsuura0831/dupyter:gpu

ADD keras.requirements.txt /

RUN apt-get update && \
  apt-get install -y graphviz && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# install anaconda and jupyter library
RUN eval "$(pyenv init -)" && \
  conda create -y -n keras python=3.5 anaconda && \
    pip install tensorflow && \
    pip install -r /keras.requirements.txt && \
  pyenv deactivate
