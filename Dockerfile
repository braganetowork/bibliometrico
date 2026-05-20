FROM rocker/r-ver:4.4.1

# ---- Dependências de sistema ----
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    pandoc \
  && rm -rf /var/lib/apt/lists/*

# ---- Pacotes R (etapa separada para cache do Docker) ----
RUN R -e "install.packages( \
    c('plumber', 'bibliometrix', 'openxlsx'), \
    repos = 'https://cloud.r-project.org', \
    Ncpus  = 4  \
  )"

WORKDIR /app

COPY app.R   .
COPY index.html .
COPY run.R   .

EXPOSE 10000

CMD ["Rscript", "run.R"]
