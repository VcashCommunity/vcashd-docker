# Vcash Docker

A dockerized version of vcashd with a very simple bash script for making
JSON-RPC calls.

## Usage

```bash
mkdir ~/.Vcash
docker run -d -v "$HOME/.Vcash:/root/.Vcash" --name vcash --restart always 0e8bee02/vcashd-docker
```

## JSON-RPC

```bash
docker exec vcash <command> <args>
```

Examples:

```bash
docker exec vcash getinfo
docker exec vcash sendtoaddress <address> <amount>
```
