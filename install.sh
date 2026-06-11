#!/bin/sh
sudo xbps-remove -Ry pulseaudio
sudo xbps-install -Sy pipewire wireplumber alsa-pipewire libspa-bluetooth pavucontrol turnstile
sudo ln -sf /etc/sv/dbus /var/service/
sudo ln -sf /etc/sv/turnstiled /var/service/

sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -sf /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -sf /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

sudo mkdir -p /etc/alsa/conf.d
sudo ln -sf /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d/
sudo ln -sf /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/

mkdir -p "$HOME/.config/autostart"
ln -sf /usr/share/applications/pipewire.desktop "$HOME/.config/autostart/"

echo "---------------------------------------------------------"
echo 'Done! If you are running a Window Manager (i3, sway....),'
echo "make sure to include these lines in your startup config:"
echo "pipewire &"
echo "--------------------------------------------------------"
