## Introduction

This project intends to re-wrap the openvino's [Multi Camera Multi Target Demo](https://docs.openvinotoolkit.org/latest/omz_demos_multi_camera_multi_target_tracking_demo_python.html) into a more accessible way.  All dependents( pre-built models) are included.  

## Requirements
* a x86 Linux host
* docker runtime
* X Window System display server

## Usage
* pull the image
```
docker pull ghcr.io/changtimwu/retail_ovmc_demo
```

* On your Linux desktop, launch `xterm` and use `xhost` command to permit X clients
```
xhost +
```

* the the image
```
docker run -itu root -e DISPLAY=:0 --net=host -v /tmp/.X11-unix:/tmp/.X11-unix:rw --name openvino_multicam_reid -v <your media path>:/opt/work --rm retail_ovmc_demo
```

## Build and Deploy
* build the image by the command
```
make
```
* Proper Github Actions have been setup to automatically build the whole demo as a docker image.  By default, it will publish the result image to github's Container registry.


## Reference
* the [Dockerfile](https://github.com/openvinotoolkit/docker_ci/blob/master/dockerfiles/ubuntu20/openvino_cgvh_dev_2021.4.dockerfile) of the base image [openvino/ubuntu20_dev](https://hub.docker.com/r/openvino/ubuntu20_dev)`

