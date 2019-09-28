FROM rust:1.38.0-buster

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh

RUN USERNAME=rust \
    && adduser --disabled-password --gecos "" --uid 1000 $USERNAME \
    && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
