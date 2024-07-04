FROM pytorch/pytorch:2.3.1-cuda11.8-cudnn8-devel

# https://stackoverflow.com/a/78179631

# Instalar dependências
RUN apt-get update && \
    apt-get install -y pciutils wget cmake git build-essential libncurses5-dev libncursesw5-dev libsystemd-dev libudev-dev libdrm-dev pkg-config


# Clonar e instalar nvtop
RUN git clone https://github.com/Syllo/nvtop.git /tmp/nvtop && \
    mkdir -p /tmp/nvtop/build && \
    cd /tmp/nvtop/build && \
    cmake .. && \
    make && \
    make install && \
    rm -rf /tmp/nvtop

# Limpar cache do apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Jupyter
RUN pip install jupyter
RUN pip install ipywidgets
RUN pip install jupyter_contrib_nbextensions
RUN pip install jupyterlab_code_formatter black isort
RUN pip install JLDracula
RUN pip install jupyterlab_materialdarker
RUN pip install jupyterlab-drawio
RUN pip install jupyterlab_execute_time
RUN pip install ipympl

# Dependencias
RUN pip install tensorflow==2.13
RUN pip install tensorflow-datasets==4.0.1
RUN pip install scikit-learn
RUN pip install pandas
RUN pip install matplotlib
RUN pip install seaborn

RUN mkdir /project
RUN mkdir /root/.jupyter

ENV PATH=${PATH}:/usr/local/cuda-11.8/bin
ENV PATH=${PATH}:/usr/local/cuda/bin
ENV PATH=/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
ENV CUDNN_PATH="/usr/local/cuda"
ENV LD_LIBRARY_PATH="$CUDNN_PATH/lib64:$LD_LIBRARY_PATH"


# A variável TF_CPP_MIN_LOG_LEVEL controla o nível de log do TensorFlow:
#   0: Todos os logs são mostrados (padrão).
#   1: Filtros de logs INFO.
#   2: Filtros de logs WARNING.
#   3: Filtros de logs ERROR.
ENV TF_CPP_MIN_LOG_LEVEL=3

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=*", "--port=8888", "--allow-root", "--no-browser", "--notebook-dir=/project", "--NotebookApp.token=''", "--NotebookApp.password=''", "--NotebookApp.default_url='/lab/tree'"]
