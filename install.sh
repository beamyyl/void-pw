sudo xbps-remove -Ry pulseaudio
sudo xbps-install -Sy pipewire wireplumber alsa-pipewire libspa-bluetooth pavucontrol

sudo ln -sf /etc/sv/dbus /var/service/

sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -sf /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -sf /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

sudo mkdir -p /etc/alsa/conf.d
sudo ln -sf /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d/
sudo ln -sf /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/

mkdir -p "$HOME/.config/autostart"
cp /usr/share/applications/pipewire.desktop "$HOME/.config/autostart/"
cp /usr/share/applications/pipewire-pulse.desktop "$HOME/.config/autostart/"
cp /usr/share/applications/wireplumber.desktop "$HOME/.config/autostart/"
echo "Done! If you're running a wm, make sure to include:"
echo 'pipewire &' 
echo 'wireplumber &'
echo 'pipewire-pulse &`'
echo "either in your .xinitrc, or in your wm's config file."
