FROM ubuntu:24.10

ARG USERNAME=nonroot
ARG USER_UID=10001
ARG USER_GID=10001

RUN apt-get update && \
    apt-get install -y wget gnupg apt-transport-https && \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    wget -O - 'https://release.memsql.com/release-aug2018.gpg' | apt-key add - && \
    echo "deb [arch=amd64] https://release.memsql.com/production/debian memsql main" > /etc/apt/sources.list.d/memsql.list && \
    apt-get update && \
    apt-get install -y singlestore-client singlestoredb-toolbox singlestoredb-studio && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/singlestoredb-studio && \
    chown -R $USERNAME:$USERNAME /var/lib/singlestoredb-studio && \
    chown -R $USERNAME:$USERNAME /etc/singlestore

RUN chmod -R u+w /etc/singlestore/* /var/lib/singlestoredb-studio/*

USER $USERNAME

ENTRYPOINT ["singlestoredb-studio"]
