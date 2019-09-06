FROM python:3.6

ADD aws.requirements.txt /

RUN apt-get update && \
  apt-get install -y curl unzip && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install -r /aws.requirements.txt 

RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o /tmp/session-manager-plugin.deb && \
  dpkg -i /tmp/session-manager-plugin.deb && \
  rm /tmp/session-manager-plugin.deb

RUN curl https://s3.amazonaws.com/solutions-reference/aws-instance-scheduler/latest/scheduler-cli.zip -o /tmp/scheduler-cli.zip && \
  unzip /tmp/scheduler-cli.zip -d /tmp/scheduler_cli && \
  cd /tmp/scheduler_cli && python setup.py install && \
  rm -r /tmp/scheduler-cli.zip /tmp/scheduler_cli
