#!/bin/sh

sudo xbps-install -Sy pipewire wireplumber pipewire-alsa turnstile dbus && \
sudo ln -s /etc/sv/turnstiled /var/service/ && \
sudo ln -s /etc/sv/dbus /var/service/

echo ""
echo "========================================="
echo "Choose your PipeWire autostart method:"
echo "1) Shell Profile"
echo "2) XDG Autostart"
echo "========================================="
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo "Option 1 selected (Shell Profile)"
        sleep 1.5
        echo 'pipewire > /dev/null 2>&1 & wireplumber > /dev/null 2>&1 & pipewire-pulse > /dev/null 2>&1 &' >> ~/.bash_profile && echo 'pipewire > /dev/null 2>&1 & wireplumber > /dev/null 2>&1 & pipewire-pulse > /dev/null 2>&1 &' >> ~/.zprofile
        ;;
    2)
        echo "Option 2 selected (XDG Autostart)"
        sleep 1.5
        mkdir -p /etc/pipewire/pipewire.conf.d
        ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
        mkdir -p /etc/pipewire/pipewire.conf.d
        ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
        mkdir -p ~/.config/autostart
        ln -s /usr/share/applications/pipewire.desktop ~/.config/autostart/
        ;;
    *)
        echo "Invalid choice. Skipping autostart configuration."
        ;;
esac

echo 'Done. You can now reboot or re-login'
