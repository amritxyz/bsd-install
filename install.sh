cat << "EOF"

/****************************************************************
 *								*
 *		OPEN BSD INSTALLATION SCRIPT			*
 *								*
 ****************************************************************
 */

EOF

# Install essential packages
doas pkg_add harfbuzz \
	ffmpeg xwallpaper htop xclip xdotool lf adwaita-icon-theme \
	firefox nsxiv neovim mpv newsraft cmixer \
	unzip zathura zathura-pdf-poppler scrot \
	rust go ripgrep hugo wget transmission \
	ubuntu-nerd-fonts screenfetch intel-media-driver
# xdg-user-dirs xdg-utils
# gimp obs xf86-video-intel
# wget nodejs
# font-hack-ttf
# Create necessary directories
mkdir -p $HOME/.local/share $HOME/.config $HOME/.local/src $HOME/.local/bin $HOME/.local/hugo-dir $HOME/.local/dox $HOME/.local/vids

# Copy configuration files
cat << "EOF"

/****************************************************
 *						    *
 *		CONFIGURING DOTFILES		    *
 *						    *
 ****************************************************
 */

EOF

# NeoVim
git clone --depth=1 https://gitlab.com/NyxVoid/nvim.git $HOME/.config/nvim

# Dev
git clone --depth=1 https://gitlab.com/NyxVoid/dev.git/ $HOME/.local/dev

# Clone dotfiles repository
git clone --depth=1 https://gitlab.com/NyxVoid/bsdrice.git/ $HOME/bsdrice

# Clone walls
git clone --depth=1 https://gitlab.com/NyxVoid/void-wall.git/ $HOME/.local/share/void-wall

cp -r $HOME/bsdrice/.local/share/* $HOME/.local/share &&
	cp -r $HOME/bsdrice/.local/bin/* $HOME/.local/bin &&
	cp -r $HOME/bsdrice/.config/* $HOME/.config &&
	cp $HOME/bsdrice/.kshrc $HOME/.kshrc &&
	cp $HOME/bsdrice/.profile $HOME/.profile &&
	cp $HOME/bsdrice/.xinitrc $HOME/.xinitrc &&
	cp $HOME/bsdrice/.tmux.conf $HOME/.tmux.conf &&

cat << "EOF"

/************************************************************
 *							    *
 *		INSTALLING SUCKLESS SOFTWARE		    *
 *							    *
 ************************************************************
 */

EOF

# Clone and build dwm environment
git clone --depth=1 https://gitlab.com/NyxVoid/bsd-dwm.git/ $HOME/.local/src/bsd-dwm

doas make -C ~/.local/src/bsd-dwm/dwm/ clean install
doas make -C ~/.local/src/bsd-dwm/dmenu/ clean install
doas make -C ~/.local/src/bsd-dwm/st/ clean install
doas make -C ~/.local/src/bsd-dwm/slstatus/ clean install

# doas mkdir -p /etc/X11/xorg.conf.d/
# doas cp $HOME/bsdrice/.local/share/20-intel.conf /etc/X11/xorg.conf.d/
doas cp $HOME/bsdrice/.local/share/hosts /etc/hosts
doas cp $HOME/bsdrice/.local/share/hostname.iwm0 /etc/hostname.iwm0
doas cp $HOME/bsdrice/.local/share/sysctl.conf /etc/sysctl.conf

# Clean home directory
mkdir -p $HOME/.local/git-repos
mv $HOME/bsdrice $HOME/.local/git-repos
mv $HOME/bsd-install $HOME/.local/git-repos

# doas rm -rf /usr/X11R6/share/X11/xorg.conf.d/70-synaptics.conf
# doas rm -rf /usr/X11R6/share/X11/xorg.conf.d/*

echo "void in sound group"
doas usermod -G _sndio void

# Performance improvements
doas rcctl enable apmd
doas rcctl set apmd status on
doas rcctl set apmd flags -H
doas usermod -L staff void
doas usermod -G staff void

# fstab
sed '/\.a \/ ffs rw/ s/\(rw\)\(,softdep\)\?/\1,softdep/' "/etc/fstab" > "$HOME/fstab"
doas cp $HOME/fstab /etc/fstab

# firefox
# doas sed -i "s|^~/Downloads rwc$|~/.local/dl rwc|" /usr/local/lib/firefox/browser/defaults/preferences/unveil.main

# mkdir -p $HOME/.cache
# doas chown void:void $HOME/.cache

cat << "EOF"

/********************************************************
 *							*
 *		SUCCESSFULLY CONFIGURED			*
 *							*
 ********************************************************
 */

EOF
