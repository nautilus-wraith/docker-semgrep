FROM ubuntu:24.04 as downloader

RUN apt-get update && apt-get install -y curl
RUN curl -o /tmp/semgrep-json-to-sarif.py https://raw.githubusercontent.com/r2c-CSE/semgrep-utilities/refs/heads/main/utilities/github-sarif-helper/src/semgrep-json-to-sarif.py

# FROM semgrep/semgrep:latest
FROM semgrep/semgrep:1.120.0

COPY --from=downloader /tmp/semgrep-json-to-sarif.py /transform/semgrep-json-to-sarif.py

