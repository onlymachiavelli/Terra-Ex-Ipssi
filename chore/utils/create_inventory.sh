#!/bin/bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/display.sh"

create_inventory() {
  local env="${1:-dev}"
  local script_dir
  script_dir="$(dirname "${BASH_SOURCE[0]}")"
  local tf_env_dir="${2:-$script_dir/../../infra/envs/$env}"
  local output_name="${3:-instance_public_ip}"
  local root_dir="$script_dir/../.."
  local ssh_key="${ANSIBLE_SSH_PRIVATE_KEY:-$HOME/.ssh/terra_tp_dev}"

  display_msg "reading terraform output '$output_name' from $tf_env_dir" info

  local vm_public_ip
  vm_public_ip=$(terraform -chdir="$tf_env_dir" output -raw "$output_name")

  if [ -z "$vm_public_ip" ]; then
    display_msg "no ip output" error
    exit 1
  fi
  display_msg "instance IP: $vm_public_ip" success

  mkdir -p "$root_dir/ansible"
  {
    echo "[dev]"
    echo "$vm_public_ip ansible_user=ubuntu ansible_ssh_private_key_file=$ssh_key"
  } >"$root_dir/ansible/inventory.ini"

  display_msg "wrote $root_dir/ansible/inventory.ini" success
}

create_inventory "${1:-}" "${2:-}" "${3:-}"
