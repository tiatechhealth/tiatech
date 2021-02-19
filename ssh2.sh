#!/bin/bash
USERNAME=root
HOSTS="117.193.76.178"
PORT="8042"
SCRIPT="pwd; ls"
for HOSTNAME in ${HOSTS} ; do
    ssh -P ${PORT} ${USERNAME}@${HOSTNAME} "${SCRIPT}"
done
