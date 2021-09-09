FROM openvino/ubuntu20_dev
USER root
RUN apt-get update -y && apt-get install -y nano ffmpeg vim net-tools iputils-ping xterm
ENV MCMTDIR=${INTEL_OPENVINO_DIR}/deployment_tools/open_model_zoo/demos/multi_camera_multi_target_tracking_demo
ENV MCMTDIRPY=${MCMTDIR}/python
ADD intel ${MCMTDIRPY}/intel
ADD run.sh ${MCMTDIRPY}/
ADD multi_camera_multi_target_tracking_demo.py $MCMTDIRPY/
ADD visualization.py $MCMTDIRPY/utils
ADD configs/* ${MCMTDIRPY}/configs/ 
WORKDIR ${MCMTDIRPY}
CMD ${MCMTDIRPY}/run.sh


