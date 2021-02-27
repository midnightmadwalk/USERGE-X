FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV PIP_NO_CACHE_DIR 1

WORKDIR /app/

RUN apt-get update && apt upgrade -y && apt-get install sudo -y
RUN apt -qq install -y --no-install-recommends \
    apt-utils \
    curl \
    git \
    gnupg2 \
    wget \
    unzip \
    apt-transport-https \
    build-essential coreutils jq pv \
    gcc \
    ffmpeg mediainfo \
    neofetch \
    libfreetype6-dev libjpeg-dev libpng-dev libgif-dev libwebp-dev \
    python3-dev zlib1g-dev
    
RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

COPY requirements.txt .

RUN pip install -U setuptools setuptools-scm wheel && pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

RUN rm okteto-stack.yml

CMD [ "bash", "./run" ]
