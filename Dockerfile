FROM argonian1234/apegen2.0@sha256:925684965ac09286cb6fe9e4672282fcf2cd69df1cf4c4fef27dfc3e92bef122

# install the notebook package
RUN python3 -m pip install --no-cache-dir notebook jupyterlab
RUN python3 -m pip install --no-cache-dir jupyterhub
RUN python3 -m pip install --no-cache-dir nglview

# create user with a home directory
ARG NB_USER=binderuser
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
WORKDIR ${HOME}
USER ${NB_USER}

# Activate the environment on entry as a user
RUN echo "source activate apegen" >> ~/.bashrc
ENV PATH "/mamba/envs/apegen/bin:$PATH"

ENTRYPOINT [""]