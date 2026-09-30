# Linux Server Health Monitor

A Bash-based monitoring script for Linux that checks CPU, memory, disk usage and network reachability, writes results to a log file, and raises alerts when thresholds are crossed. Runs automatically via cron, is containerized with Docker, and is validated by a GitHub Actions pipeline.

## Tools
Linux (Bash, cron, top/free/df/ping) | Docker | GitHub Actions (ShellCheck + image build)

## Run locally
```bash
chmod +x monitor.sh
./monitor.sh
cat logs/health.log
```

## Automate with cron (every 5 minutes)
```bash
crontab -e
*/5 * * * * cd /path/to/linux-health-monitor && ./monitor.sh
```

## Run with Docker
```bash
docker build -t health-monitor .
docker run --rm health-monitor
```

## Configuration
Edit the thresholds (`CPU_LIMIT`, `MEM_LIMIT`, `DISK_LIMIT`) and `HOST_TO_PING` at the top of `monitor.sh`.

## Sample log
```
[2026-10-01 10:00:01] CPU=12% MEM=41% DISK=37%
[2026-10-01 10:00:01] Network OK (8.8.8.8 reachable)
```

## CI pipeline
On every push, GitHub Actions lints the script with ShellCheck and builds the Docker image.

## What I learned
Linux system metrics, Bash scripting, cron scheduling, basic network checks, containerization and CI.
