FROM nvidia/cuda:11.8.0-cudnn8-devel-centos7

WORKDIR /opt/ollama

RUN yum update -y && \
    yum install -y wget curl && \
    yum clean all && \
    rm -rf /var/cache/yum/*

COPY entry.sh /opt/ollama/entry.sh

RUN chmod +x /opt/ollama/entry.sh

# Copy the install.sh script into the container
COPY install.sh /opt/ollama/install.sh

RUN chmod +x /opt/ollama/install.sh

RUN /opt/ollama/install.sh

ENV OLLAMA_DEBUG=1
ENV OLLAMA_HOST=0.0.0.0

EXPOSE 11434

# # Set the entrypoint
# ENTRYPOINT ["/usr/bin/ollama"]

CMD ["/opt/ollama/entry.sh"]
