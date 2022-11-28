#!/bin/bash

VL_ARGS=()
if [ -n "${LOG_LEVEL}" ]; then
    VL_ARGS+=("-l" "${LOG_LEVEL}")
fi
echo "vulcan-local -t . ${VL_ARGS[*]}"
vulcan-local -t . "${VL_ARGS[@]}"
