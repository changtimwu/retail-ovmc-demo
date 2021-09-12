#!/bin/bash
is_url() {
    regex='(https?|http|file|rtsp)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    [[ $1 =~ $regex ]]
}

source ${INTEL_OPENVINO_DIR}/bin/setupvars.sh

[ -z "$DET_MODEL" ] && DET_MODEL="person-detection-retail-0013"
[ -z "$REID_MODEL" ] && REID_MODEL="person-reidentification-retail-0277"
[ -z "$video_file" ] && video_file="PETS09-S2L1-raw.webm"

export pdxml="./intel/${DET_MODEL}/FP32/${DET_MODEL}.xml"
export reidxml="./intel/${REID_MODEL}/FP32/${REID_MODEL}.xml"
export workp="/opt/work/"

form_vsrcs_args() {
    input=$1
    arr=(${input//,/ })
    rets=""
    for i in "${arr[@]}"; do
        if is_url $i ; then
            rets+=" $i"
        else
            rets+=" $workp/$i"
        fi
    done
    echo $rets
}

export inv="-i $(form_vsrcs_args $video_file)"
export prognm="multi_camera_multi_target_tracking_demo.py"
export logopts="--history_file $workp/history_results.json --save_detections $workp/detections.json"
cfgdir="./configs/"
if [ -d $workp/configs/ ]; then
    echo "found custom config directory"
    cfgdir="$workp/configs"
fi
export cfgopts="--config $cfgdir/person.py"
export miscopts=""
[ -n "$no_show_id" ] && miscopts+="--no_show_id"
pwd
echo "python3 $prognm $inv -m $pdxml --m_reid $reidxml $logopts $cfgopts $miscopts"
python3 $prognm $inv -m $pdxml --m_reid $reidxml $logopts $cfgopts $miscopts


