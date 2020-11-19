FROM debian:8

ADD build.sh /opt/tiger/mdk/

RUN chmod +x /opt/tiger/mdk/build.sh
RUN /bin/bash /opt/tiger/mdk/build.sh