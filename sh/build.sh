#!/bin/bash
# Build GUIdi
# Usage: [sudo] "sh/build.sh"

build() {
	fan src/build_pod.fan
}

# Except on Cygwin, this most likely will need to be run as root
if [[ `uname` =~ CYGWIN.+ ]]; then
	build
else
	if [[ "$(id -u)" != "0" ]]; then
		echo "You must run this as root."
		echo "e.g. \"sudo sh/build.sh\""
	fi
fi
