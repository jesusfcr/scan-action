#!/bin/bash

VL_ARGS=()

# Setting log level
if [ -n "${LOG_LEVEL}" ]; then
    VL_ARGS+=("-l" "${LOG_LEVEL}")
fi

# Adding images
if [ -n "${TARGET_IMAGES}" ]; then
    for TIMG in ${TARGET_IMAGE_REFS}; do
        VL_ARGS+=("-t" "${TIMG}" "-a" "DockerImage")
    done
fi

# Scan paths as GitRepository
if [ -n "${TARGET_GITREPOS}" ]; then
    for TR in ${TARGET_PATHS}; do
        VL_ARGS+=("-t" "${TR}" "-a" "GitRepository")
    done
fi

if [ -n "${SCAN_REPO}" ]; then
    VL_ARGS+=("-t" "." "-a" "GitRepository")
fi

echo "vulcan-local ${VL_ARGS[*]}"
vulcan-local "${VL_ARGS[@]}"
