# Start from Ubuntu base image
FROM ubuntu:20.04

# Set the Python version as an environment variable
ENV PYTHON_VERSION 3.9.13

# Set the working directory
WORKDIR /usr/src/app

# Copy the requirements.txt into the container
COPY requirements.txt ./

# Setup for installing dependencies, including build-essential
ENV EXTRA_APT_PACKAGES "build-essential"

# For ARM64 we need to install additional packages
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        EXTRA_APT_PACKAGES="libhdf5-serial-dev pkg-config build-essential"; \
    else \
        EXTRA_APT_PACKAGES="build-essential"; \
    fi && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends $EXTRA_APT_PACKAGES curl bzip2 ca-certificates git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install mamba (from Miniforge) and use it to install Python 3.9.13
RUN curl -sSL https://github.com/conda-forge/miniforge/releases/download/4.10.3-1/Mambaforge-4.10.3-1-Linux-x86_64.sh -o mambaforge.sh && \
    bash mambaforge.sh -b -p /opt/conda && \
    rm mambaforge.sh && \
    /opt/conda/bin/conda clean -a && \
    export PATH=/opt/conda/bin:$PATH && \
    /opt/conda/bin/mamba install -y python=${PYTHON_VERSION} -c conda-forge

# Set environment variables for conda
ENV PATH=/opt/conda/bin:$PATH

# Set up conda channels and install other dependencies
RUN conda config --add channels conda-forge && \
    conda config --set channel_priority strict

# Install dependencies from the requirements.txt file
RUN pip install --no-cache-dir -r requirements.txt

# Optionally install any additional packages (e.g., cloudpickle)
RUN conda install --yes cloudpickle

