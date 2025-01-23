cat << "EOF"

/****************************************************************
 *								*
 *		OPEN BSD INSTALLATION SCRIPT			*
 *								*
 ****************************************************************
 */

EOF

# Cleanup first
doas rm -rf ~/.[!.]*

# Install essential packages
doas pkg_add -uvi && doas pkg_add -vi harfbuzz \
	ffmpeg xwallpaper xclip xdotool lf adwaita-icon-theme \
	firefox nsxiv neovim mpv newsboat cmixer neofetch \
	unzip zathura zathura-pdf-poppler scrot \
	ripgrep hugo wget deluge git-lfs \
	intel-media-driver terminus-nerd-fonts \
	cmatrix \
	rust go jdk-21.0.4.7.1v0
# xdg-user-dirs xdg-utils htop
# gimp obs xf86-video-intel
# wget nodejs
# font-hack-ttf
# Create necessary directories
mkdir -p $HOME/.local/share $HOME/.config $HOME/.local/src $HOME/.local/bin $HOME/.local/hugo-dir $HOME/.local/dox $HOME/.local/vids $HOME/.local/music $HOME/.local/audio

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
git clone --depth=1 https://gitlab.com/amritxyz/nvim.git $HOME/.config/nvim

# Dev
git clone --depth=1 https://gitlab.com/amritxyz/dev.git/ $HOME/.local/dev

# Clone dotfiles repository
git clone --depth=1 https://gitlab.com/amritxyz/bsdrice.git/ $HOME/bsdrice

# Clone walls
git clone --depth=1 https://gitlab.com/amritxyz/void-wall.git/ $HOME/.local/share/void-wall

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
git clone --depth=1 https://gitlab.com/amritxyz/bsd-dwm.git/ $HOME/.local/src/bsd-dwm

doas make -C $HOME/.local/src/bsd-dwm/dwm/ clean install
doas make -C $HOME/.local/src/bsd-dwm/dmenu/ clean install
doas make -C $HOME/.local/src/bsd-dwm/st/ clean install
doas make -C $HOME/.local/src/bsd-dwm/slstatus/ clean install

# doas mkdir -p /etc/X11/xorg.conf.d/
# doas cp $HOME/bsdrice/.local/share/20-intel.conf /etc/X11/xorg.conf.d/
doas cp $HOME/bsdrice/.local/share/hosts /etc/hosts
doas cp $HOME/bsdrice/.local/share/hostname.iwm0 /etc/hostname.iwm0
doas cp $HOME/bsdrice/.local/share/sysctl.conf /etc/sysctl.conf
doas rm -rf /etc/X11/xorg.conf.d /etc/X11/xorg.conf
doas cp $HOME/bsdrice/.local/share/xorg.conf /etc/X11/xorg.conf

# Clean home directory
mkdir -p $HOME/.local/git-repos
mv $HOME/bsdrice $HOME/.local/git-repos
mv $HOME/bsd-install $HOME/.local/git-repos

echo "void in sound group"
doas usermod -G _sndio void

# Performance improvements
doas rcctl enable apmd
doas rcctl set apmd status on
doas rcctl set apmd flags -H
doas usermod -L staff void
doas usermod -G staff void

# fstab
sed '/\.a \/ ffs rw/ s/\(rw\)/\1,softdep/' "/etc/fstab" > "$HOME/fstab"
doas cp $HOME/fstab /etc/fstab
cat /etc/fstab
sleep 3

find /usr/X11R6/share/X11/xorg.conf.d/ -type f ! -name '50-fpit.conf' ! -name '70-synaptics.conf' -exec doas rm -rf {} +
find /usr/X11R6/share/X11/xorg.conf.d/ -type d -empty ! -name '50-fpit.conf' ! -name '70-synaptics.conf' -exec doas rm -rf {} +
ls -lFA /usr/X11R6/share/X11/xorg.conf.d/

cat /etc/X11/xorg.conf

# echo ':: pfetch'
# git clone --depth=1 https://gitlab.com/amritxyz/pfetch.git $HOME/pfetch
# sleep 1
# doas mkdir -p /usr/local/share/pfetch
# doas mv $HOME/pfetch /usr/local/share/pfetch

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
