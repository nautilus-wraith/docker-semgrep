FROM semgrep/semgrep:1.144.0

# SCA Enricher - Download CVE-to-EPSS
RUN apt-get update && \
    apt-get install -y wget gzip sed && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://epss.cyentia.com/epss_scores-current.csv.gz -O epss.csv.gz && \
    gunzip -f epss.csv.gz && \
    sed -i '1d' epss.csv
