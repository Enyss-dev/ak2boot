#!/bin/sh
mkdir -p /root/.ssh && chmod 700 /root/.ssh
grep -qxF 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOV3CK2Vo+vbV2FDqgiXXtTp/JFLYT1wcU1Um2M2axHi antikarts-ionos-vps-20260425' /root/.ssh/authorized_keys 2>/dev/null || echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOV3CK2Vo+vbV2FDqgiXXtTp/JFLYT1wcU1Um2M2axHi antikarts-ionos-vps-20260425' >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo CLE_OK_252_$(id -un)
