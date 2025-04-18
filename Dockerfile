FROM python:3.12.3-alpine3.19
LABEL maintainer="cenariodigital.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    # The following three lines are the hack to use psycopg2 instead of psycopg2-binary, and
    # were found by test and error.
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
    build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
	    rm -rf /tmp && \
	    apk del .tmp-build-deps && \
	    adduser \
	        --disabled-password \
	        --no-create-home \
	        django-user

ENV PATH="/py/bin:$PATH"