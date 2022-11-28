#!/bin/bash

set -e

VL_ARGS=()

# Setting log level
if [ -n "${LOG_LEVEL}" ]; then
    VL_ARGS+=("-l" "${LOG_LEVEL}")
fi

# Adding images
if [ -n "${TARGET_IMAGES}" ]; then
    for TIMG in ${TARGET_IMAGES}; do
        VL_ARGS+=("-t" "${TIMG}" "-a" "DockerImage")
    done
fi

# Scan paths as GitRepository
if [ -n "${TARGET_GITREPOS}" ]; then
    for TR in ${TARGET_GITREPOS}; do
        VL_ARGS+=("-t" "${TR}" "-a" "GitRepository")
    done
fi

if [ -n "${SCAN_REPO}" ]; then
    VL_ARGS+=("-t" "." "-a" "GitRepository")
fi

if [ -n "${REPORT_SEVERITY}" ]; then
    VL_ARGS+=("-s" "$REPORT_SEVERITY" )
fi

if [ "${USE_LOCAL_CONFIG}" == "true" ]; then
    if [ -f "${LOCAL_CONFIG}" ]; then   # local not an url.
        VL_ARGS+=("-c" "$LOCAL_CONFIG" )
    fi
fi

# Create a temp file for report
TMPD=$(mktemp -d)
OUTPUT_REPORT="$TMPD/report.json"
VL_ARGS+=("-r" "$OUTPUT_REPORT")

echo "vulcan-local ${VL_ARGS[*]}"
vulcan-local "${VL_ARGS[@]}" || exit_status=$?

echo "report=$OUTPUT_REPORT" >> "$GITHUB_OUTPUT"

echo "Exit status $exit_status"
