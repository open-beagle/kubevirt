ARG BASE

FROM $BASE

ARG AUTHOR
ARG VERSION

LABEL maintainer=$AUTHOR version=$VERSION

ARG TARGETOS
ARG TARGETARCH

COPY ./_out/dist/$TARGETARCH/virt-operator/virt-operator-$VERSION-$TARGETOS-$TARGETARCH/ /usr/local/bin/

ARG USER=code
ENV HOME /home/$USER

# install sudo as root
RUN apk add --update sudo bash

# add new user
RUN adduser -u 1001 -h $HOME -s /bin/bash -D $USER \
  && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
  && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR $HOME
