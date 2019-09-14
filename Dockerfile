FROM ubuntu:latest

# SET NONINTERACTIVE
ENV DEBIAN_FRONTEND "noninteractive"

RUN apt update

RUN apt install -y --no-install-recommends \
    git \
    net-tools \
    python3 \
    rxvt-unicode \
    supervisor \
    ttf-dejavu \
    x11vnc \
    xorg \
    xserver-xorg

RUN apt install -y --no-install-recommends \
    xvfb \
    bspwm

RUN apt install -y --no-install-recommends \
    firefox

RUN apt install -y --no-install-recommends \
    feh \
    xsettingsd \
    aptitude \
    nano

# noVNC setup
WORKDIR /usr/share/
RUN git clone https://github.com/kanaka/noVNC.git
WORKDIR /usr/share/noVNC/utils/
RUN git clone https://github.com/kanaka/websockify

RUN export DISPLAY=:0.0

COPY supervisord.conf /etc/

EXPOSE 8083

RUN useradd -m user
WORKDIR /home/user

ENV SHELL=/bin/bash

RUN mkdir -p /root/.config/bspwm/
COPY bspwmrc /root/.config/bspwm/
COPY sxhkdrc /root/.config/sxhkd/
COPY wallpaper.png /root/
COPY .Xresources /root/
COPY .xsettingsd /root/
RUN chmod +x /root/.config/bspwm/bspwmrc

CMD ["/usr/bin/supervisord"]
