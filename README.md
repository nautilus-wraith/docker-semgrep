# semgrep

Builds Semgrep image used in the SAST/SCA SDLC workflows.

Includes Sarif post-processing script for human readable findings severity levels: https://github.com/r2c-CSE/semgrep-utilities/tree/main/utilities/github-sarif-helper

Containers pushed to Nautilus Organisation Package registry: https://github.com/orgs/nautilus-wraith/packages

Image contain also EPSS table used for EPSS filtering in SCA scans. That is why we rebuild the image regularly.