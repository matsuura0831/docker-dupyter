#!/bin/bash

FLAG_AUTH=${AUTH:=0}

CONF=$HOME/.jupyter/jupyter_notebook_config.py

if [ "$FLAG_AUTH" == "0" ]; then
  echo "c.NotebookApp.token = ''" >> $CONF
  echo "c.NotebookApp.password = ''" >> $CONF
fi

jupyter nbextension enable --py --sys-prefix widgetsnbextension
xvfb-run -s "-screen 0 1400x900x24" \
  jupyter notebook --ip='*' --notebook-dir=/workspace --no-browser --allow-root
