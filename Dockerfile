FROM condaforge/mambaforge:latest

ENV PYTHON_VERSION 3.9.13

WORKDIR /usr/src/app

COPY requirements.txt ./

# Setup before undi installation; TOBE optimized.
ENV EXTRA_APT_PACKAGES "build-essential"

# For ARM64 we need to install erlang as it is not available on conda-forge
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        EXTRA_APT_PACKAGES="libhdf5-serial-dev pkg-config build-essential"; \
    else \
        EXTRA_APT_PACKAGES="build-essential"; \
    fi && \
    apt-get update --yes && \
    apt-get install --yes --no-install-recommends $EXTRA_APT_PACKAGES && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# End setup before undi installation

# Create a new conda environment with the specified Python version
RUN mamba create -y -n myenv python=${PYTHON_VERSION} && \
    echo "conda activate myenv" >> /root/.bashrc

RUN echo "which python" >> /root/.bashrc

RUN conda config --add channels conda-forge && \
    conda config --set channel_priority strict

RUN conda run -n myenv conda install --yes cloudpickle && \
    conda run -n myenv pip install --no-cache-dir -r requirements.txt
