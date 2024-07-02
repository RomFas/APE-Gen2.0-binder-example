FROM argonian1234/apegen2.0@sha256:d03577d214c2617d0234e9f12cd37a8c796e67878aab58215c618da600390acf

# install the notebook package
RUN python3 -m pip install --no-cache-dir notebook jupyterlab
RUN python3 -m pip install --no-cache-dir jupyterhub

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