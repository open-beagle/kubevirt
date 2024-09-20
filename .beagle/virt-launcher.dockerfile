ARG BASE

FROM $BASE

ARG AUTHOR
ARG VERSION

LABEL maintainer=$AUTHOR version=$VERSION

ARG TARGETOS
ARG TARGETARCH

RUN apk add --no-cache libvirt-dev

COPY ./_out/dist/$TARGETARCH/virt-launcher/virt-launcher-$VERSION-$TARGETOS-$TARGETARCH/ /usr/local/bin/virt-launcher
