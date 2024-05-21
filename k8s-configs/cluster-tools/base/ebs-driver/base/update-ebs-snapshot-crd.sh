#!/bin/bash
set -e

USAGE="./update-ebs-snapshot-crd.sh DRIVER_VERSION"
REQ_PATH="k8s-configs/cluster-tools/base/ebs-driver/base"

if [[ ! "$(pwd)" = *"${REQ_PATH}"* ]]; then
    echo "Script run source sanity check failed. Please only run this script in ${REQ_PATH}"
    exit 1
fi

if [[ $# != 1 ]]; then
    echo "Usage: ${USAGE}"
    exit 1
fi

EBS_SNAPSHOT_CRD_VERSION="${1}"
KUBERNETES_CSI_REPO="https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter"

curl "$KUBERNETES_CSI_REPO/${EBS_SNAPSHOT_CRD_VERSION}/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml" \
    -o volumesnapshotcontents.yaml
curl "$KUBERNETES_CSI_REPO/${EBS_SNAPSHOT_CRD_VERSION}/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml" \
    -o volumesnapshots.yaml
curl "$KUBERNETES_CSI_REPO/${EBS_SNAPSHOT_CRD_VERSION}/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml" \
    -o volumesnapshotclasses.yaml

echo "EBS Snapshot CRD update complete, check your 'git diff' to see what changed"
