FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
    ca-certificates \
    offlineimap \
    wget

RUN wget -O /usr/bin/tickerd https://github.com/josh/tickerd/releases/latest/download/tickerd-linux-amd64 && chmod +x /usr/bin/tickerd

WORKDIR /root

COPY entrypoint.sh .
COPY offlineimaprc .offlineimaprc

RUN mkdir Maildir

ENTRYPOINT [ "./entrypoint.sh" ]

ENV TICKERD_HEALTHCHECK_FILE "/var/log/healthcheck"
HEALTHCHECK --interval=30s --timeout=3s --start-period=3s --retries=1 \
  CMD ["/usr/bin/tickerd", "-healthcheck"]
