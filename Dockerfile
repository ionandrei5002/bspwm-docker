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
    compton \
    xsettingsd \
    aptitude \
    nano \
    dmenu \
    less \
    yabar \
    fonts-mononoki \
    sudo

# noVNC setup
WORKDIR /usr/share/
RUN git clone https://github.com/kanaka/noVNC.git
WORKDIR /usr/share/noVNC/utils/
RUN git clone https://github.com/kanaka/websockify

RUN export DISPLAY=:0.0

COPY supervisord.conf /etc/

EXPOSE 8083

RUN useradd -m andrei
RUN usermod -d /home/andrei andrei
# ENV USER andrei
WORKDIR /home/andrei/

ENV SHELL=/bin/bash

RUN mkdir -p /home/andrei/.config/bspwm/
COPY bspwmrc /home/andrei/.config/bspwm/
COPY sxhkdrc /home/andrei/.config/sxhkd/
COPY wallpaper.png /home/andrei/
COPY .Xresources /home/andrei/
COPY .xsettingsd /home/andrei/
COPY compton.conf /home/andrei/.config/
COPY yabar.conf /home/andrei/.config/yabar/
COPY xstartup /home/andrei/.vnc/
RUN chmod +x /home/andrei/.config/bspwm/bspwmrc
RUN chown -R andrei:andrei /home/andrei/

USER andrei

CMD ["/usr/bin/supervisord"]
