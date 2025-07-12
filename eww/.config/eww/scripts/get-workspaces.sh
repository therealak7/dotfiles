#!/usr/bin/env bash
niri msg --json workspaces | jq 'length'
