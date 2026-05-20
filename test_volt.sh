#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<'EOF'

Note: Code is cloned from git inside the container, so make sure to commit and push first.
EOF
  exit 0
fi

export PYTHON_SCRIPT="pretrain pythia-14m"
export GPUS_PER_NODE="${GPUS_PER_NODE:-4}"
export RUN_COMMAND="litgpt"

export JOB_PREFIX="${NANOCHAT_BASE_DIR:-litgpt-test}"

# export SETUP_COMMAND="\
# mkdir -p ${NANOCHAT_BASE_DIR}; \
# aws s3 sync s3://graphcore-research-us-east-1/albertoc/nanochat/.cache/nanochat/ ${NANOCHAT_BASE_DIR}; \
# pip install torch==2.9.1 --index-url https://download.pytorch.org/whl/cu128; \
# pip install -r pip_requirements.txt"

bash k8s-scripts/submit-volt.sh -- \
  --config config_hub/pretrain/debug.yaml
