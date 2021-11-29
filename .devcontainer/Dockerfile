FROM ghcr.io/julia-vscode/julia-devcontainer


RUN apt update -y   && \
    apt upgrade -y  && \
    apt-get install texlive-full -y && \
    rm -rf /var/lib/apt/lists/*
# Install Miniconda
RUN curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b && \
    rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}

# Install Jupyter
RUN conda update -y conda && \
    conda install -y -c conda-forge jupyterlab