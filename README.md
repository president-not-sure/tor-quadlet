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

### Template

In your parent project quadlet, symlink to the templates. The instance-name needs to be modified to something unique like your parent project name.

```bash
ln -sf tor@.container tor@instance-name.container
ln -sf tor-external@.network tor-external@instance-name.network
ln -sf tor-internal@.network tor-internal@instance-name.network
```

There is also a possibility of overriding the template using systemd overrides for added flexibility.

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
