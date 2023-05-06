# syntax=docker/dockerfile:1
FROM base-image

RUN sudo apt install -y cowsay fortune

ENV PATH $PATH:/usr/games

WORKDIR /work

COPY --chmod=755 command.sh ./

CMD ["./command.sh"]
