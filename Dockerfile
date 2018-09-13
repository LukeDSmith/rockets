FROM python:3-alpine

#Make directory for cli files
RUN mkdir -p /rockets_cli
ADD rockets_cli /rockets_cli

#Set up logrotation directories
RUN mkdir -p /var/log/rockets_cli
RUN apk update && \
    apk add logrotate
COPY conf/logrotate/rockets_cli /etc/logrotate.d/

WORKDIR /rockets_cli

RUN apk add bash && \
    apk add --virtual build-deps gcc python-dev musl-dev libffi-dev

#COPY requirements.txt /rocket_cli/requirements.txt
RUN pip3 install ${pip_index_url} --no-cache-dir -r requirements.txt


RUN mkdir -p /usr/local/bin
COPY /rockets_cli/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
