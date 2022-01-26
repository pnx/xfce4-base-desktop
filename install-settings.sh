#!/bin/bash

DIR=$(dirname $(readlink -f "$0"))

source "$DIR/config.sh"

function replace_vars {
	cat "$1" \
		| sed "s~{{.*XFCE4_FONT_DEFAULT.*}}~${XFCE4_FONT_DEFAULT}~" \
		| sed "s~{{.*XFCE4_FONT_MONO.*}}~${XFCE4_FONT_MONO}~" \
		| sed "s~{{.*XFCE4_THEME.*}}~${XFCE4_THEME}~" \
		| sed "s~{{.*XFCE4_ICON.*}}~${XFCE4_ICON}~" \
		| sed "s~{{.*XFCE4_CURSOR.*}}~${XFCE4_CURSOR}~" \
		| sed "s~{{.*XFCE4_PANEL_CLOCK_FORMAT.*}}~${XFCE4_PANEL_CLOCK_FORMAT}~" \
		| sed "s~{{.*LIGHTDM_BACKGROUND.*}}~${LIGHTDM_BACKGROUND}~" \
		| sed "s~{{.*LIGHTDM_THEME.*}}~${LIGHTDM_THEME}~" \
		| sed "s~{{.*LIGHTDM_ICON_THEME.*}}~${LIGHTDM_ICON_THEME}~" \
		| sed "s~{{.*LIGHTDM_CURSOR_THEME.*}}~${LIGHTDM_CURSOR_THEME}~" \
		| sed "s~{{.*LIGHTDM_CURSOR_SIZE.*}}~${LIGHTDM_CURSOR_SIZE}~" \
		| sed "s~{{.*LIGHTDM_FONT.*}}~${LIGHTDM_FONT}~"
}

# Unpack themes
sudo mkdir -p /usr/share/{themes,icons}
sudo tar -J -x -f "$DIR/archive/${XFCE4_THEME_ARCHIVE}" -C "/usr/share/themes"
sudo tar -J -x -f "$DIR/archive/${XFCE4_ICON_ARCHIVE}" -C "/usr/share/icons"

# Copy wallpapers
sudo cp -r "$DIR/wallpapers/"* /usr/share/backgrounds

# Symlink lightdm background
sudo ln -sf "${LIGHTDM_BACKGROUND}" /usr/share/backgrounds/lightdm

# Install config files
sudo mkdir -p /etc/xdg/xfce4/{terminal,panel,xfconf/xfce-perchannel-xml}
replace_vars "$DIR/config/xfconf/xfce-perchannel-xml/xfwm4.xml" | sudo tee /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml > /dev/null
replace_vars "$DIR/config/xfconf/xfce-perchannel-xml/xsettings.xml" | sudo tee /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml > /dev/null
replace_vars "$DIR/config/terminal/terminalrc" | sudo tee /etc/xdg/xfce4/terminal/terminalrc > /dev/null
replace_vars "$DIR/config/panel/default.xml" | sudo tee /etc/xdg/xfce4/panel/default.xml > /dev/null
replace_vars "$DIR/config/lightdm-gtk-greeter.conf" | sudo tee /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
