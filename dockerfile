LABEL   version="1.0" \
        description="DNSMasq for homelab with conf in local storage"

FROM alpine:edge

# webproc release settings
#ENV WEBPROC_VERSION 0.1.9
#ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/$WEBPROC_VERSION/webproc_linux_amd64.gz

# fetch dnsmasq and webproc binary
RUN apk update \
	&& apk --no-cache add dnsmasq
#	&& apk --no-cache add dnsmasq \
#	&& apk add --no-cache --virtual .build-deps curl \
#	&& curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc \
#	&& chmod +x /usr/local/bin/webproc \
#	&& apk del .build-deps

#configure dnsmasq
RUN mkdir -p /etc/default/
RUN echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq
COPY /Volumes/Data/Docker/Dockerfile/dnsmasq/dnsmasq.conf /etc/dnsmasq.conf

#configure docker for dnsmas (don't forget to use docker run -p <your ports> or -P)
EXPOSE 53:53/udp

#run!
#ENTRYPOINT ["webproc","--config","/etc/dnsmasq.conf","--","dnsmasq","--no-daemon"]
ENTRYPOINT ["dnsmasq","--keep-in-foreground"]