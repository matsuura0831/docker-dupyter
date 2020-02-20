#!/bin/bash

PORT=${PORT:=8888}
SCREEN=${SCREEN:=1400x900x24}

FLAG_AUTH=${AUTH:=0}

CONF=$HOME/.jupyter/jupyter_notebook_config.py
if [ "$FLAG_AUTH" == "0" ]; then
  echo "c.NotebookApp.token = ''" >> $CONF
  echo "c.NotebookApp.password = ''" >> $CONF
fi

xvfb-run -s "-screen 0 ${SCREEN}" \
  jupyter lab --ip="0.0.0.0" --port=${PORT} --notebook-dir=/workspace --allow-root
