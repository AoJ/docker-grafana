FROM centos:7

# init process
RUN curl -L https://github.com/nicolas-van/multirun/releases/download/1.0.0/multirun-glibc-1.0.0.tar.gz     \
    | tar -C /bin -zx multirun                                                                              \
    && echo "feac7b8e4d79dae3d19cc4287d80e0b537e71458933c5c752492ac30de8b2fed  /bin/multirun"               \
    | sha256sum --check --status                                                                            \
    && echo 'PS1="[\\e[33;1m\\u@\h \\e[31m\\w\\e[0m]\\$ "' >> /etc/bashrc


RUN yum upgrade -y


# latest urls are in https://grafana.com/grafana/download?platform=linux
ENV GRAFANA_URL=https://dl.grafana.com/oss/release/grafana-8.3.0.linux-amd64.tar.gz \
    GRAFANA_SHA256=a3cbb0f5546e2bddc86d981c666166676cdb80a76bc866de68f02542bf30257c \
    GRAFANA_HOME=/opt/grafana


COPY scripts/grafana_download.sh /tmp/
RUN chmod +x /tmp/grafana_download.sh
RUN /tmp/grafana_download.sh && rm -f /tmp/grafana_download.sh


EXPOSE 9090
WORKDIR $GRAFANA_HOME
ENTRYPOINT ["/bin/multirun", "-v"]
CMD ["$GRAFANA_HOME/prometheus","--config.file", "/etc/grafana/grafana.yml"]

