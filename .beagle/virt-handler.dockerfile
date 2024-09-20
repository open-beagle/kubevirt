ARG BASE

FROM $BASE

ARG AUTHOR
ARG VERSION

LABEL maintainer=$AUTHOR version=$VERSION

ARG TARGETOS
ARG TARGETARCH

COPY ./_out/dist/$TARGETARCH/virt-handler/virt-handler-$VERSION-$TARGETOS-$TARGETARCH/ /usr/local/bin/virt-handler
