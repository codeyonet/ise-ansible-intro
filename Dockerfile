FROM python:3.11.12-slim

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    ANSIBLE_FORCE_COLOR=true

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        libffi-dev \
        libssl-dev \
        python3-dev \
        sshpass \
        curl \
        git \
        vim \
        gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install specific Ansible version
RUN pip install --upgrade pip && \
    pip install ansible==11.3.0

# Install Cisco ISE SDK (if version is known, pin it)
RUN pip install ciscoisesdk==2.3.1

# Install exact Ansible Galaxy collections (versions pinned for reproducibility)
RUN ansible-galaxy collection install cisco.ise:==2.10.0

WORKDIR /workspace

CMD [ "bash" ]
