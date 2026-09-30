FROM ubuntu:22.04
RUN apt-get update && apt-get install -y procps iputils-ping && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY monitor.sh .
RUN mkdir -p logs && chmod +x monitor.sh
CMD ["./monitor.sh"]
