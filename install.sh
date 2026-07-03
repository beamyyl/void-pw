#!/bin/sh

echo "Installing prerequisites..."
sudo xbps-install -Sy pipewire wireplumber turnstile dbus

echo "Enabling system services..."
[ -e /var/service/turnstiled ] || sudo ln -s /etc/sv/turnstiled /var/service/
[ -e /var/service/dbus ] || sudo ln -s /etc/sv/dbus /var/service/

echo "Configuring PipeWire modular structure..."
mkdir -p "$HOME/.config/pipewire/pipewire.conf.d"
ln -sf /usr/share/examples/wireplumber/10-wireplumber.conf "$HOME/.config/pipewire/pipewire.conf.d/"
ln -sf /usr/share/examples/pipewire/20-pipewire-pulse.conf "$HOME/.config/pipewire/pipewire.conf.d/"

echo ""
echo "========================================="
echo "Choose your PipeWire autostart method:"
echo "1) Shell Profile (~/.bash_profile & ~/.zprofile)"
echo "2) XDG Autostart (~/.config/autostart)"
echo "========================================="
printf "Enter your choice (1 or 2): "
read choice

case $choice in
    1)
        echo "Option 1 selected (Shell Profile)"
        sleep 1
        CMD="if ! pgrep -x \"pipewire\" > /dev/null; then pipewire >/dev/null 2>&1 & fi"
        echo "$CMD" >> "$HOME/.bash_profile"
        echo "$CMD" >> "$HOME/.zprofile"
        echo "Added pw to shell profile."
        ;;
    2)
        echo "Option 2 selected (XDG Autostart)"
        sleep 1
        mkdir -p "$HOME/.config/autostart"
        ln -sf /usr/share/applications/pipewire.desktop "$HOME/.config/autostart/"
        echo "Linked pipewire.desktop to user autostart folder."
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
