## Introduction

This project intends to re-wrap the openvino's [Multi Camera Multi Target Demo](https://docs.openvinotoolkit.org/latest/omz_demos_multi_camera_multi_target_tracking_demo_python.html) into a more accessible way.  All dependents( pre-built models) are included.  

## Requirements
* a x86 Linux host
* docker runtime
* X Window System display server

## Prepare
* pull the image
```
docker pull ghcr.io/changtimwu/retail_ovmc_demo:main
```

* On your Linux desktop, launch `xterm` and use `xhost` command to permit X clients
```
xhost +
```

## Run the image
* fixed arguments
  - `-e DISPLAY=:0 --net=host -v /tmp/.X11-unix:/tmp/.X11-unix:rw`: make X server transparent between host and containers 

* arguments
  - `-v work_path`: specify the path where the input video files and output results to be store
  - `-e DET_MODEL`: specify the detection model
  - `-e REID_MODEL`: specify the ReID model
  - `-e video_file`: the video files to be analyzed in `work_path` or video source in URL form
* optional arguments
  - `-e no_show_id=1`: show only the bounding box without the identification number

## Examples
* analyze a mp4 file
```
docker run -itu root -e DISPLAY=:0 --net=host -v /tmp/.X11-unix:/tmp/.X11-unix:rw --name openvino_multicam_reid -v <your media/save path>:/opt/work -e video_file=abc.mp4 --rm retail_ovmc_demo
```
* analyze multiple RTSP streams
```
docker run -itu root -e DISPLAY=:0 --net=host -v /tmp/.X11-unix:/tmp/.X11-unix:rw --name openvino_multicam_reid -v <your media/save path>:/opt/work -e video_file="rtsp://user:password@192.168.1.12/stream2,rtsp://user:password@192.168.1.13/stream2" --rm retail_ovmc_demo

```

## List of models
* Detection model -- specified with `-e DET_MODEL=`
  - `person-detection-retail-0013`

* ReID model -- specified with `-e REID_MODEL=`
  - `person-reidentification-retail-0277`
  - `person-reidentification-retail-0286`
  - `person-reidentification-retail-0287`
  - `person-reidentification-retail-0288`

## Output 

while input video is playing, you're supposed to see the people identifed with colored rectangle and number.  

![Alt text](/screenshots/reidss.png?raw=true "reid screen shot")

`detections.json` and `history_results.json` would be saved into the working directory



## Build and Deploy
* build the image by the command
```
make
```
* Proper Github Actions have been setup to automatically build the whole demo as a docker image.  By default, it will publish the result image to github's Container registry.

## Reference
* the [Dockerfile](https://github.com/openvinotoolkit/docker_ci/blob/master/dockerfiles/ubuntu20/openvino_cgvh_dev_2021.4.dockerfile) of the base image [openvino/ubuntu20_dev](https://hub.docker.com/r/openvino/ubuntu20_dev)`

