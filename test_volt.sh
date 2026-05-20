#!/usr/bin/env bash
set -euo pipefail

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<'EOF'

Note: Code is cloned from git inside the container, so make sure to commit and push first.
EOF
  exit 0
fi

export GPUS_PER_NODE="${GPUS_PER_NODE:-4}"
export JOB_PREFIX="${NANOCHAT_BASE_DIR:-litgpt_test}"

export RUN_COMMAND="litgpt"
export PYTHON_SCRIPT="pretrain pythia-14m"

export SETUP_COMMAND="\
pip install -e '.[extra,test,compiler]'; \
litgpt download EleutherAI/pythia-14m --tokenizer_only true; \
"

bash k8s-scripts/submit-volt.sh \
  --config config_hub/pretrain/debug.yaml \
  --logger_name wandb
