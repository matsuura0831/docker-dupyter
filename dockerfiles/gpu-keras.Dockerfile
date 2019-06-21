FROM matsuura0831/dupyter:latest

RUN apt-get update && \
  apt-get install -y graphviz && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# install anaconda and jupyter library
RUN eval "$(pyenv init -)" && \
  conda create -y -n keras python=3.5 anaconda && \
    pip install -r keras.requirements.txt && \
    pip uninstall -y tensorflow && \
    pip install tensorflow-gpu
  pyenv deactivate
