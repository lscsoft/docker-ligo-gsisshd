FROM containers.ligo.org/docker/software:buster

RUN adduser --quiet --system --no-create-home --home /var/run/sshd --shell /usr/sbin/nologin sshd

COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh
COPY /entrypoint/startup /usr/local/bin/startup
RUN chmod 0755 /usr/local/bin/startup

RUN apt-get update && \
    apt-get install --assume-yes \
      cvmfs \
      cvmfs-x509-helper \
      emacs-nox \
      ldg-client \
      ldg-core \
      globus-gridftp-server-progs \
      gsi-openssh-server \
      ligo-grid-mapfile-manager \
      sshfs \
      sudo \
      vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN gsissh-keygen -A

EXPOSE 22
ENTRYPOINT [ "/usr/local/bin/startup" ]
CMD ["-e"]
