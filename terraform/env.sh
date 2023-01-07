#!/bin/sh
cat <<EOF
{
  "linode_api_token": "$(cat linode_api_token)",
  "root_pass": "$(cat root_pass)"
}
EOF
