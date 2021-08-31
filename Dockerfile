ARG APLINE_VERSION=3.12.7
ARG BUILD_FROM="alpine:${APLINE_VERSION}"

######## BUILD ########
FROM $BUILD_FROM as buildstage

RUN apk --update upgrade \
 && apk add --no-cache git build-base \
 && git config --global http.sslVerify false \
 && git clone https://github.com/Eba-M/E3DC-Control /E3DC-Control \
 && cd /E3DC-Control \
 && sed -i 's/memcpy(&vecDynamicBuffer\[0\], &vecDynamicBuffer\[0\]/memmove(\&vecDynamicBuffer[0], \&vecDynamicBuffer[0]/g' RscpExampleMain.cpp \
 && sed -i 's/%lu\\n", vecDynamicBuffer.size()/%lu\\n", (unsigned long) vecDynamicBuffer.size()/g' RscpExampleMain.cpp \
 && make

######## RUN ########
FROM $BUILD_FROM

ARG BUILD_DATE
ARG BUILD_VERSION
ARG BUILD_REVISION

LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.authors="Christian Kulbe <chriskbua@mail.de>" \
      org.opencontainers.image.url="https://hub.docker.com/r/chriskuba/e3dc-control" \
      org.opencontainers.image.documentation="https://github.com/ChrisKuBa/docker-E3DC-Control/blob/main/README.md" \
      org.opencontainers.image.source="https://github.com/ChrisKuBa/docker--E3DC-Control" \
      org.opencontainers.image.version=$BUILD_VERSION \
      org.opencontainers.image.title=e3dc-control \
      org.opencontainers.image.description="This simple alpine docker container running https://github.com/Eba-M/E3DC-Control." \
      org.opencontainers.image.base.name=alpine:$APLINE_VERSION \
      org.opencontainers.image.revision=$BUILD_REVISION \
      functionalmaintainer="Eberhard Mayer, eba auf https://www.photovoltaikforum.com" \
      thanksto="Steffen Hartmann, pv@steffenhartmann.de"
#     org.opencontainers.image.base.digest=""
#LABEL org.opencontainers.image.vendor=""
#LABEL org.opencontainers.image.licenses="GPL-2.0"
#LABEL org.opencontainers.image.ref.name=""

RUN apk upgrade --update \
 && apk add -U libstdc++ \
               screen \
 && adduser -D -u 1111 service_user service_user

WORKDIR /home/service_user

COPY --from=buildstage --chown=service_user:service_user /E3DC-Control/E3DC-Control .

COPY --chown=service_user:service_user E3DC.sh E3DC-Screen.sh .

RUN chmod 500 E3DC-Control \
 && chmod 500 E3DC.sh \
 && chmod 500 E3DC-Screen.sh

USER service_user

#ENTRYPOINT ["/bin/ash", "-c", "while true; do sleep 30; done;"]
ENTRYPOINT ["/home/service_user/E3DC-Screen.sh"]
