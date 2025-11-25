FROM ubuntu:22.04 AS epss-builder
RUN apt-get update && \
    apt-get install -y wget gzip sed && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /work
RUN wget https://epss.cyentia.com/epss_scores-current.csv.gz -O epss.csv.gz && \
    gunzip -f epss.csv.gz && \
    sed -i '1d' epss.csv

FROM semgrep/semgrep:1.144.0

COPY --from=epss-builder /work/epss.csv epss.csv