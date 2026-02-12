FROM quay.io/fedora/fedora:latest as build

COPY tor.repo /etc/yum.repos.d

RUN dnf --use-host-config --installroot=/staging -y install tor curl && \
    dnf --use-host-config --installroot=/staging -y clean all

FROM scratch

COPY --from=build /staging /

USER toranon

ENTRYPOINT ["/usr/bin/tor"]
