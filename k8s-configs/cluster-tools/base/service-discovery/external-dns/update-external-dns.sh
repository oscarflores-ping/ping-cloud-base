#!/bin/bash
set -e

USAGE="./update-external-dns.sh EXTERNAL_DNS_VERSION"
REQ_PATH="k8s-configs/cluster-tools/base/service-discovery/external-dns"

if [[ ! "$(pwd)" = *"${REQ_PATH}"* ]]; then
    echo "Script run source sanity check failed. Please only run this script in ${REQ_PATH}"
    exit 1
fi

if [[ $# != 1 ]]; then
    echo "Usage: ${USAGE}"
    exit 1
fi

EXTERNAL_DNS_VERSION="${1}"
EXTERNAL_DNS_RAW_URL="${EXTERNAL_DNS_RAW_URL}"

curl "${EXTERNAL_DNS_RAW_URL}/${EXTERNAL_DNS_VERSION}/kustomize/external-dns-clusterrole.yaml" -o external-dns-clusterrole.yaml
curl "${EXTERNAL_DNS_RAW_URL}/${EXTERNAL_DNS_VERSION}/kustomize/external-dns-clusterrolebinding.yaml" -o external-dns-clusterrolebinding.yaml
curl "${EXTERNAL_DNS_RAW_URL}/${EXTERNAL_DNS_VERSION}/kustomize/external-dns-deployment.yaml" -o external-dns-deployment.yaml
curl "${EXTERNAL_DNS_RAW_URL}/${EXTERNAL_DNS_VERSION}/kustomize/external-dns-serviceaccount.yaml" -o external-dns-serviceaccount.yaml

echo "external-dns update complete, check your 'git diff' to see what changed"