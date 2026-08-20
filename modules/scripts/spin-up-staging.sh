#!/usr/bin/env bash

set -euo pipefail

export AWS_PROFILE="luis_staging"

cluster="stg-cyber4all-cluster-use1-c8ef755f"
services=(
  "stg-clark-gateway-use1-c83f8041"
  "stg-clark-service-use1-c8825bc9"
  "stg-standard-guidelines-service-use1-c8b967ac"
)
script_name="${0##*/}"

usage() {
  echo "Usage: ${script_name} --up|--down"
  echo
  echo "Flags:"
  echo "  -u, --up      Spin staging services up"
  echo "  -d, --down    Spin staging services down"
  echo "  -h, --help    Show this help message"
}

set_scaling() {
  local service="$1"
  local min_capacity="$2"

  aws application-autoscaling register-scalable-target \
    --service-namespace ecs \
    --scalable-dimension ecs:service:DesiredCount \
    --resource-id "service/${cluster}/${service}" \
    --min-capacity "${min_capacity}" \
    --max-capacity 3
}

set_desired_count() {
  local service="$1"
  local desired_count="$2"

  aws ecs update-service \
    --cluster "${cluster}" \
    --service "${service}" \
    --desired-count "${desired_count}"
}

spin() {
  local min_capacity="$1"
  local desired_count="$2"

  for service in "${services[@]}"; do
    echo "Setting ${service}: min=${min_capacity}, desired=${desired_count}"
    set_scaling "${service}" "${min_capacity}"
    set_desired_count "${service}" "${desired_count}"
  done
}

if [[ $# -ne 1 ]]; then
  usage
  exit 1
fi

case "$1" in
  -u|--up)
    spin 1 1
    ;;
  -d|--down)
    spin 0 0
    ;;
  -h|--help)
    usage
    ;;
  *)
    usage
    exit 1
    ;;
esac
