#!/bin/bash
# Build GUIdi
# Usage: [sudo] "sh/build.sh"
#export FAN_ENV=util::PathEnv
#export FAN_ENV_PATH=.

# Except on Cygwin, this most likely will need to be run as root
if [[ `uname` != "CYGWIN*" ]]; then
	if [[ "$(id -u)" != "0" ]]; then
		echo "You must run this as root."
		echo "e.g. \"sudo sh/build.sh\""
		exit 1
	fi
fi
fan src/build_pod.fan

