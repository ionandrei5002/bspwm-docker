docker run \
    --rm \
    --privileged \
    -it \
    -p 8083:8083 \
    -e DISPLAY=:0.0 \
    bspwm-docker:latest \
    supervisord