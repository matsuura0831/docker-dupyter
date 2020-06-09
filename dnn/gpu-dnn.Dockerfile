FROM matsuura0831/dupyter:gpu

# install pip packages
ADD ./requirements/gpu.dnn.requirements.txt /dnn.requirements.txt
RUN pip install -r /dnn.requirements.txt