#!/bin/bash

docker image build -t local_node -<<EOF
FROM node:14

RUN usermod -u 1001 node
RUN groupmod -g 1001 node
RUN useradd -u ${UID} -ms /bin/bash ${USER}
RUN chown -R ${USER} /home/${USER}

USER ${USER}
EOF