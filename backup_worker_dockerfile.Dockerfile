FROM postgres:latest

# Install cron
RUN apt-get update && apt-get install -y cron
RUN apk add --update \
    python \
    py-pip \
    py-cffi \
    py-cryptography \
    bash \
    curl \
    && pip install --upgrade pip \
    && apk add --virtual build-deps \
    gcc \
    libffi-dev \
    python-dev \
    linux-headers \
    musl-dev \
    openssl-dev \
    && pip install gsutil \
    && apk del build-deps \
    && rm -rf /var/cache/apk/*

# install the gcloud SDK- 
# this allows us to use gcloud auth inside the container
RUN curl -sSL https://sdk.cloud.google.com > /tmp/gcl \
    && bash /tmp/gcl --install-dir=~/gcloud --disable-prompts
# Copy the scripts
COPY ./scripts /scripts

# Make sure the scripts are executable
RUN chmod +x /scripts/*.sh
