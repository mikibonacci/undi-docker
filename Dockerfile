FROM condaforge/mambaforge:latest

WORKDIR /usr/src/app

COPY requirements.txt ./

# Setup before Phonopy installation; TOBE optimized.
ENV EXTRA_APT_PACKAGES "build-essential"

# For ARM64 we need to install erlang as it is not available on conda-forge
#ARG TARGETARCH
#RUN if [ "$TARGETARCH" = "arm64" ]; then \

RUN EXTRA_APT_PACKAGES="libhdf5-serial-dev pkg-config ${EXTRA_APT_PACKAGES}"; \
         apt-get update --yes &&  \
         apt-get install --yes --no-install-recommends ${EXTRA_APT_PACKAGES} && \
         apt-get clean && rm -rf /var/lib/apt/lists/*

#    fi;
# End setup before Phonopy installation

RUN conda config --add channels conda-forge
RUN conda config --set channel_priority strict
RUN conda install --yes cloudpickle
RUN pip install --no-cache-dir -r requirements.txt
