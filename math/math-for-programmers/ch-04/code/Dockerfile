FROM continuumio/anaconda3

RUN /opt/conda/bin/conda update -n base -c defaults conda && \
    /opt/conda/bin/conda install python=3.6 && \
    /opt/conda/bin/conda install matplotlib -y && \
    /opt/conda/bin/conda install opengl pygame

RUN ["mkdir", "python_code"]
COPY conf/.jupyter /root/.jupyter
COPY run_code.sh /

VOLUME /python_code

CMD ["/run_code.sh"]