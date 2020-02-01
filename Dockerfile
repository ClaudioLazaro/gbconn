FROM  ubuntu
LABEL maintener="clazar <claudiolazarosantos@gmail.com>"
LABEL version="0.1"
LABEL description="Openconnect for gp in docker - Corporate"

RUN set -ex \
    && apt-get update \
    && apt-get upgrade \ 
    && apt-get install -y \
    build-essential gettext autoconf automake libproxy-dev git curl iptables \
    libxml2-dev libtool vpnc-scripts pkg-config zlib1g-dev \
    libgnutls28-dev adwaita-icon-theme at-spi2-core dbus dconf-gsettings-backend dconf-service fontconfig \ 
    fontconfig-config fonts-dejavu-core glib-networking glib-networking-common glib-networking-services \
    gsettings-desktop-schemas gtk-update-icon-cache hicolor-icon-theme humanity-icon-theme i965-va-driver \ 
    libaacs0 libapparmor1 libasyncns0 libatk-bridge2.0-0 libatk1.0-0 libatk1.0-data libatspi2.0-0 \
    libavahi-client3 libavahi-common-data libavahi-common3 libavcodec57 libavformat57 libavutil55 \
    libbdplus0 libbluray2 libbsd0 libcairo-gobject2 libcairo2 libcap2 libchromaprint1 libcolord2 libcrystalhd3 \
    libcups2 libdatrie1 libdbus-1-3 libdconf1 libdouble-conversion1 libdrm-amdgpu1 libdrm-common \ 
    libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 libdrm2 libedit2 libegl-mesa0 libegl1 libepoxy0 libevdev2 libflac8 \
    libfontconfig1 libgbm1 libgdk-pixbuf2.0-0 libgdk-pixbuf2.0-bin libgdk-pixbuf2.0-common \
    libgl1 libgl1-mesa-dri libglapi-mesa libglvnd0 libglx-mesa0 libglx0 libgme0 libgsm1 libgtk-3-0 libgtk-3-bin \
    libgtk-3-common libgudev-1.0-0 libice6 libinput-bin libinput10 libjbig0 libjpeg-turbo8 libjpeg8 \
    libjson-glib-1.0-0 libjson-glib-1.0-common liblcms2-2 libllvm8 libmp3lame0 libmpg123-0 libmtdev1 libnuma1 \
    libogg0 libopenjp2-7 libopenmpt0 libopus0 libpango-1.0-0 libpangocairo-1.0-0 \
    libpangoft2-1.0-0 libpciaccess0 libpixman-1-0 libpulse0 libpulsedsp libqt5core5a libqt5dbus5 libqt5gui5 libqt5network5 libqt5svg5 \
    libqt5widgets5 librest-0.7-0 librsvg2-2 librsvg2-common libsensors4 libshine3 \
    libsm6 libsnappy1v5 libsndfile1 libsoup-gnome2.4-1 libsoup2.4-1 libsoxr0 libspeex1 libssh-gcrypt-4 libswresample2 libswscale4 \
    libthai-data libthai0 libtheora0 libtiff5 libtwolame0 libv4l-0 libv4lconvert0 \
    libva-drm2 libva-x11-2 libva2 libvdpau1 libvorbis0a libvorbisenc2 libvorbisfile3 libvpx5 libwacom-bin libwacom-common libwacom2 \
    libwavpack1 libwayland-client0 libwayland-cursor0 libwayland-egl1 libwayland-server0 \
    libwebp6 libwebpmux3 libwrap0 libx11-6 libx11-data libx11-xcb1 libx264-152 libx265-146 libxau6 libxcb-dri2-0 libxcb-dri3-0 \
    libxcb-glx0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-present0 libxcb-randr0 \
    libxcb-render-util0 libxcb-render0 libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcb-util1 libxcb-xfixes0 libxcb-xinerama0 \
    libxcb-xkb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxdmcp6 libxext6 \
    libxfixes3 libxi6 libxinerama1 libxkbcommon-x11-0 libxkbcommon0 libxkbfile1 libxmu6 libxrandr2 libxrender1 libxshmfence1 libxss1 \
    libxt6 libxtst6 libxv1 libxvidcore4 libxxf86vm1 libzvbi-common libzvbi0 mesa-va-drivers \
    mesa-vdpau-drivers multiarch-support pulseaudio-utils qt5-gtk-platformtheme qttranslations5-l10n ubuntu-mono ucf \
    va-driver-all vdpau-driver-all x11-common xkb-data stoken sudo inetutils-ping telnet nano \
##    libnvidia-cfg1-435:amd64 libnvidia-common-435 libnvidia-compute-435:amd64 \
##    libnvidia-decode-435:amd64 libnvidia-encode-435:amd64 libnvidia-fbc1-435:amd64 libnvidia-gl-435:amd64 \
##    libnvidia-ifr1-435:amd64 nvidia-compute-utils-435 nvidia-dkms-435 nvidia-driver-435 nvidia-kernel-common-435 \
##    nvidia-kernel-source-435 nvidia-prime nvidia-settings nvidia-utils-435 screen-resolution-extra xserver-xorg-video-nvidia-435 \
## COPIAR DO GITHUB
    && git clone https://github.com/dlenski/openconnect.git /tmp/openconnect-globalprotect \
    && curl -O https://www.tel.red/linux.php?f=sky_2.1.7458-1ubuntu%2Bbionic_amd64.deb \
    && dpkg -i *.deb \	
## INSTALANDO GB 
    && cd /tmp/openconnect-globalprotect \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install && ldconfig\
    && apt-get clean
##RUN groupadd --gid 1000 admin &&
RUN adduser \
    --disabled-password \
    --gecos "" \
    --shell /bin/bash \
    --home /home/admin \
    --uid 1000 \	
    admin && \	
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Customized the sudoers file for passwordless access to the amin user!"

COPY content /home/admin/ 
RUN chown admin:admin /home/admin/connvpn.sh  && chmod +x /home/admin/connvpn.sh 
USER admin
ENTRYPOINT ["/bin/bash"]




