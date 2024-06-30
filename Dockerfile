FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel

RUN apt update
RUN apt-get install pciutils -y
RUN apt install wget -y

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
RUN pip install tensorflow==2.12.0
RUN pip install tensorflow-datasets==4.0.1
RUN pip install scikit-learn
RUN pip install pandas
RUN pip install matplotlib
RUN pip install seaborn

RUN mkdir /project
RUN mkdir /root/.jupyter

ENV PATH=${PATH}:/usr/local/cuda-11.7/bin


# A variável TF_CPP_MIN_LOG_LEVEL controla o nível de log do TensorFlow:
#   0: Todos os logs são mostrados (padrão).
#   1: Filtros de logs INFO.
#   2: Filtros de logs WARNING.
#   3: Filtros de logs ERROR.
ENV TF_CPP_MIN_LOG_LEVEL=3



EXPOSE 8888

CMD ["jupyter", "lab", "--ip=*", "--port=8888", "--allow-root", "--no-browser", "--notebook-dir=/project", "--NotebookApp.token=''", "--NotebookApp.password=''", "--NotebookApp.default_url='/lab/tree'"]
