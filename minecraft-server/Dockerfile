FROM openjdk:16-jdk-alpine AS spigot-builder

ARG SPIGOT_VER
ENV SPIGOT_VER $SPIGOT_VER

WORKDIR /work/BuildTools
RUN set -x && \
  apk add --no-cache git && \
  wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar && \
  java -jar BuildTools.jar -rev $SPIGOT_VER && \
  mv spigot-${SPIGOT_VER}.jar spigot.jar

FROM openjdk:8-jre-alpine AS minecraft-server

EXPOSE 25565

WORKDIR /
COPY --from=spigot-builder /work/BuildTools/spigot.jar ./spigot.jar
COPY ./spigot-start.sh ./spigot-start.sh

WORKDIR /var/server-contents
ENTRYPOINT ["/spigot-start.sh"]
CMD ["4096", "8192"]
