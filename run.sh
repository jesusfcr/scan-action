#!/bin/bash

VL_ARGS=()
if [ -e "${LOG_LEVEL}" ]; then
    VL_ARGS+=("-l" "${LOG_LEVEL}")
fi
echo "log-level ${LOG_LEVEL}"
echo "vulcan-local -t . ${VL_ARGS[*]}"
vulcan-local -t . "${VL_ARGS[@]}"
