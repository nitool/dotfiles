FROM node:14

RUN usermod -u 1001 node
RUN groupmod -g 1001 node
RUN useradd -u 1000 -ms /bin/bash nitool
RUN chown -R nitool /home/nitool

USER nitool

