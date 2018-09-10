FROM python:3-alpine

RUN mkdir -p /rockets_cli
ADD rockets_cli /rockets_cli
WORKDIR /rockets_cli

RUN apk update && \
    apk add bash && \
    apk add --virtual build-deps gcc python-dev musl-dev libffi-dev

#COPY requirements.txt /rocket_cli/requirements.txt
RUN pip3 install ${pip_index_url} --no-cache-dir -r requirements.txt

RUN mkdir -p /usr/local/bin
COPY /rockets_cli/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD tail -f /dev/null
