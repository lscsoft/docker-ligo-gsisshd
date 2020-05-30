FROM igwn/software:el7

LABEL name="LIGO gsissh server for Enterprise Linux 7" \
      maintainer="Shawn Kwang <shawn.kwang@ligo.org>" \
      date="20190918" \
      support="Reference Platform"

RUN adduser --system --no-create-home --home-dir /var/run/sshd --shell /usr/sbin/nologin sshd

COPY /environment/bash/ligo.sh /etc/profile.d/ligo.sh
COPY /entrypoint/startup /usr/local/bin/startup
RUN chmod 0755 /usr/local/bin/startup

RUN yum -y install \
      cvmfs \
      cvmfs-x509-helper \
      ldg-client \
      gsi-openssh-server \
      ligo-grid-mapfile-manager \
      globus-gridftp-server \
      sudo \
      vim && \
    yum clean all

RUN gsissh-keygen -A

EXPOSE 22
ENTRYPOINT [ "/usr/local/bin/startup" ]
CMD ["-e"]
