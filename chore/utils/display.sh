#!/bin/bash

INFO_COLOR='\033[36;1m'
ERROR_COLOR='\033[31;1m'
SUCCESS_COLOR='\033[32;1m'
RESET_COLOR='\033[m'

display_msg() {
  local msg="$1"
  local level="${2:-info}"

  case "$level" in
    error)   echo -e "${ERROR_COLOR}==> ${msg}${RESET_COLOR}" ;;
    success) echo -e "${SUCCESS_COLOR}==> ${msg}${RESET_COLOR}" ;;
    *)       echo -e "${INFO_COLOR}==> ${msg}${RESET_COLOR}" ;;
  esac
}
