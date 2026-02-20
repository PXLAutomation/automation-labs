#!/usr/bin/env bash
# Idempotently adds PXL lab entries to the host machine's /etc/hosts.
# Run automatically by the Vagrant post-up trigger, or manually.
if grep -q "PXL_LAB_BEGIN" /etc/hosts; then
  exit 0
fi

if ! sudo -n true 2>/dev/null; then
  echo "NOTE: /etc/hosts not updated (sudo requires a password). Run manually: bash update_hosts.sh"
  exit 0
fi

{
  echo ""
  echo "# PXL_LAB_BEGIN"
  echo "10.10.0.10 webserver1.pxldemo.local webserver1"
  echo "10.10.0.20 dbserver1.pxldemo.local dbserver1"
  echo "# PXL_LAB_END"
} | sudo tee -a /etc/hosts > /dev/null
