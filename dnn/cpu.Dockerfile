FROM ubuntu:18.04

ENV PYENV_ROOT /opt/pyenv
ENV PYENV_INSTALL_VERSION 3.7.6
ENV FONT_NAME IPAexGothic

ENV PATH ${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}

# install nodejs for jupyterlab
RUN apt-get update && \
  apt-get install -y tzdata && \
  apt-get install -y build-essential curl git \
    fonts-ipafont fonts-ipaexfont \
    xvfb \
    libssl-dev libffi-dev libsqlite3-dev zlib1g-dev \
    libbz2-dev \
    libopencv-dev python-opengl libsm6 libxrender1 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# install ja fonts
RUN mkdir -p $HOME/.config/matplotlib && \
  echo "font.family: ${FONT_NAME}" > ${HOME}/.config/matplotlib/matplotlibrc && \
  rm -f ${HOME}/.cache/matplotlib/fontList.cache

# install pyenv and setting for `docker run bash`
RUN git clone https://github.com/yyuu/pyenv.git ${PYENV_ROOT} && \
  git clone https://github.com/yyuu/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv && \
  echo 'eval "$(pyenv init -)"' >> ${HOME}/.bashrc

# install pyenv
RUN pyenv install ${PYENV_INSTALL_VERSION} && \
  pyenv global ${PYENV_INSTALL_VERSION} && \
  pip install --upgrade pip

# install pip packages
ADD ./requirements/base.requirements.txt /base.requirements.txt
RUN pip install -r /base.requirements.txt

# install nodejs for jupyterlab extentions
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y --no-install-recommends nodejs

# install jupyterlab extententions
RUN jupyter labextension install @lckr/jupyterlab_variableinspector && \
  jupyter labextension install @jupyterlab/toc && \
  jupyter labextension install jupyterlab_vim && \
  jupyter labextension install jupyterlab_tensorboard

WORKDIR /workspace
ADD ./scripts/entrypoint_jupyter.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
