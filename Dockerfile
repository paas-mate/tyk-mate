FROM ttbb/tyk:nake

WORKDIR /opt/tyk

COPY docker-build /opt/tyk/mate

CMD ["/usr/bin/dumb-init", "bash", "-vx", "/opt/tyk/mate/scripts/start.sh"]
