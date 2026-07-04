#!/bin/sh

sudo xbps-install -Sy pipewire wireplumber turnstile dbus

[ -e /var/service/turnstiled ] || sudo ln -s /etc/sv/turnstiled /var/service/
[ -e /var/service/dbus ] || sudo ln -s /etc/sv/dbus /var/service/

sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -sf /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -sf /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

rm -f "$HOME/.config/autostart/pipewire.desktop"
rm -rf "$HOME/.config/pipewire/pipewire.conf.d"
rm -f "$HOME/.config/service/pipewire" "$HOME/.config/service/wireplumber"

printf "Enter your choice (1 for XDG Autostart, 2 for Shell Profile, 3 to skip for GNOME/GDM): "
read choice

case $choice in
    1)
        mkdir -p "$HOME/.config/autostart"
        ln -sf /usr/share/applications/pipewire.desktop "$HOME/.config/autostart/"
        ;;
    2)
        CMD="if ! pgrep -x \"pipewire\" > /dev/null; then pipewire >/dev/null 2>&1 & fi"
        echo "$CMD" >> "$HOME/.bash_profile"
        echo "$CMD" >> "$HOME/.zprofile"
        ;;
    *)
        ;;
esac
        echo "$CMD" >> "$HOME/.zprofile"
        echo "Added pw to shell profile."
        ;;
    *)
        echo "Invalid choice. Skipping autostart configuration."
        echo "You will need to manually start 'pipewire' to get audio."
        ;;
esac

echo ""
echo "========================================="
echo "Done! Please reboot or re-login now."
echo "========================================="
