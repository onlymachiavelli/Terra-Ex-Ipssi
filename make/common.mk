.ONESHELL:
SHELL := /usr/bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

INFO_COLOR := \033[36;1m
ERROR_COLOR := \033[31;1m
SUCCESS_COLOR := \033[32;1m
WARNING_COLOR := \033[33;1m
RESET_COLOR := \033[m

ENV ?= dev
INFRA_DIR := $(CURDIR)/infra
TF_ENV_DIR := $(INFRA_DIR)/envs/$(ENV)
ANSI_DIR := ansible
