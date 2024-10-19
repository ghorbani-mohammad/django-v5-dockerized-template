#!/usr/bin/env bash

set -e

find journal \
	-type d -name migrations -prune -o \
	-type f -name "*.py" \
	-exec "$@" {} +
