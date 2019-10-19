FROM matsuura0831/dupyter:gpu-dnn

# install pip packages
ADD ./requirements/rl.requirements.txt /rl.requirements.txt
RUN pip install -r /rl.requirements.txt