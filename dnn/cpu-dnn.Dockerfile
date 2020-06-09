FROM matsuura0831/dupyter:cpu

# install pip packages
ADD ./requirements/cpu.dnn.requirements.txt /dnn.requirements.txt
RUN pip install -r /dnn.requirements.txt && \
  pip install torch==1.4.0+cpu torchvision==0.5.0+cpu -f https://download.pytorch.org/whl/torch_stable.html