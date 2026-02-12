# Tor Quadlet

A Tor Quadlet build service to be reused as a submodule for other projects. The resulting image is tagged `localhost/tor:latest`.

## Requirements

- Linux
- Podman

## Features

- Automatically rebuilds from upstream source daily
- No updates required unless upstream introduces breaking changes
- Minimal image size of ~160MB

## Install

### Rootless

```bash
podman quadlet install --replace tor
install -vD -m 0644 -t "${HOME}/.config/systemd/user" timers/tor-build.timer
systemctl --user enable --now tor-build.timer
```

### Rootful

```bash
sudo podman quadlet install --replace tor
sudo install -vD -m 0644 -t /etc/systemd/system timers/tor-build.timer
sudo systemctl enable --now tor-build.timer
```

## Uninstall

### Rootless

```bash
systemctl --user disable --now tor-build.timer
rm -rfv "${HOME}/.config/systemd/user/tor-build.timer"
podman quadlet rm --force .tor.app
```

### Rootful

```bash
sudo systemctl disable --now tor-build.timer
sudo rm -rfv /etc/systemd/system/tor-build.timer
sudo podman quadlet rm --force .tor.app
```
