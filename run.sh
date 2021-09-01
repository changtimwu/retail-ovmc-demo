#!/bin/bash
source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh
export pdxml="./intel/person-detection-retail-0013/FP32/person-detection-retail-0013.xml"
export reidxml="./intel/person-reidentification-retail-0277/FP32/person-reidentification-retail-0277.xml"

export infn="PETS09-S2L1-raw.webm"
export workp="/opt/work/"
export inv="-i $workp/$infn"
export prognm="multi_camera_multi_target_tracking_demo.py"
export logopts="--history_file $workp/history_results.json --save_detections $workp/detections.json"
export cfgopts="--config configs/person.py"
ls -al
python3 $prognm $inv -m $pdxml --m_reid $reidxml $logopts $cfgopts


