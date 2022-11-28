#!/bin/bash

VL_ARGS=()

# Setting log level
if [ -n "${LOG_LEVEL}" ]; then
    VL_ARGS+=("-l" "${LOG_LEVEL}")
fi

# Adding images
if [ -n "${TARGET_IMAGE_REFS}" ]; then
    for IMG in ${TARGET_IMAGE_REFS}; do
        VL_ARGS+=("-t" "${IMG}" "-a" "DockerImage")
    done
fi

# Adding local repo
VL_ARGS+=("-t" "." "-a" "GitRepository")

echo "vulcan-local ${VL_ARGS[*]}"
vulcan-local "${VL_ARGS[@]}"
