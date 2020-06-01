FROM python:3.8-slim-buster

ENV DEBIAN_FRONTEND noninteractive

# required to build gdal (geo library)
ENV CPLUS_INCLUDE_PATH /usr/include/gdal
ENV C_INCLUDE_PATH /usr/include/gdal

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install --no-install-recommends -yq \
      gcc \
      g++ \
      libc-dev \
      libpq-dev \
      gdal-bin \
      python3-gdal \
      libgdal-dev \
      make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ADD . /app

RUN pip install --no-cache-dir pipenv \
    && pipenv install --dev \
    && pip install --no-cache-dir nltk \
    && python -c "import nltk; nltk.download('punkt')"
