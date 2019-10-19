FROM python:3.6

ADD requirements.txt /

RUN apt-get update && \
  apt-get install -y curl unzip && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install -r /requirements.txt 

RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o /tmp/session-manager-plugin.deb && \
  dpkg -i /tmp/session-manager-plugin.deb && \
  rm /tmp/session-manager-plugin.deb
