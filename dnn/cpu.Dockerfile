FROM ubuntu:18.04

ENV ANACONDA_VERSION anaconda3-5.3.1
ENV PYENV_ROOT /opt/pyenv
ENV PATH ${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}

RUN apt-get update && \
  apt-get install -y wget git fonts-ipafont fonts-ipaexfont xvfb python-opengl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# install ja fonts
RUN mkdir -p $HOME/.config/matplotlib && \
  echo "font.family: IPAexGothic" > ${HOME}/.config/matplotlib/matplotlibrc && \
  rm -f ${HOME}/.cache/matplotlib/fontList.cache

# install pyenv and setup for `docker run bash`
RUN git clone https://github.com/yyuu/pyenv.git ${PYENV_ROOT} && \
  git clone https://github.com/yyuu/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv && \
  echo 'eval "$(pyenv init -)"' >> ${HOME}/.bashrc

# install anaconda and jupyter library
RUN pyenv install ${ANACONDA_VERSION} && \
  pyenv global ${ANACONDA_VERSION} && \
  conda update -n base conda && \
  conda update --all && \
  pip install --upgrade pip && \
  jupyter notebook --generate-config

# install pip packages
ADD ./requirements/base.requirements.txt /base.requirements.txt
RUN pip install -r /base.requirements.txt

ADD ./requirements/cpu.dnn.requirements.txt /dnn.requirements.txt
RUN pip install -r /dnn.requirements.txt

WORKDIR /workspace
ADD ./scripts/entrypoint_jupyter.sh /entrypoint_jupyter.sh
CMD ["/bin/bash", "/entrypoint_jupyter.sh"]
