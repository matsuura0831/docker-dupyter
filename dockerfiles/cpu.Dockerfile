ARG UBUNTU=18.04

FROM ubuntu:${UBUNTU}

ARG ANACONDA_VERSION=anaconda3-5.3.1
ENV PYENV_ROOT /opt/pyenv
ENV PATH ${PYENV_ROOT}/bin:${PATH}

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
RUN eval "$(pyenv init -)" && \
  pyenv install ${ANACONDA_VERSION} && \
  pyenv global ${ANACONDA_VERSION} && \
  conda update -n base conda && \
  pip install environment_kernels && \
  jupyter notebook --generate-config

# setup jupyter
RUN echo "c.NotebookApp.kernel_spec_manager_class='environment_kernels.EnvironmentKernelSpecManager'" >> ${HOME}/.jupyter/jupyter_notebook_config.py && \
  echo "c.EnvironmentKernelSpecManager.conda_env_dirs=['${PYENV_ROOT}/versions/${ANACONDA_VERSION}/envs']" >> ${HOME}/.jupyter/jupyter_notebook_config.py

ADD ./entrypoint.sh /entrypoint.sh

WORKDIR /workspace

CMD ["/bin/bash", "/entrypoint.sh"]
