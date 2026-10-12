#!/usr/bin/env bash
set -euo pipefail
: "${LAYOUT_SPICE:?Set LAYOUT_SPICE to the layout-extracted SPICE/CDL netlist}"
: "${REFERENCE_SPICE:?Set REFERENCE_SPICE to the trusted reference SPICE/CDL netlist}"
: "${NETGEN_SETUP:?Set NETGEN_SETUP to the Sky130 Netgen setup file}"
: "${LVS_REPORT:=physical/signoff/lvs.log}"
for f in "$LAYOUT_SPICE" "$REFERENCE_SPICE" "$NETGEN_SETUP"; do
  [[ -f "$f" ]] || { echo "Missing required file: $f" >&2; exit 2; }
done
command -v netgen >/dev/null 2>&1 || { echo "netgen not found in PATH" >&2; exit 2; }
mkdir -p "$(dirname "$LVS_REPORT")"
netgen -batch lvs "$LAYOUT_SPICE" digital_lock_controller "$REFERENCE_SPICE" digital_lock_controller "$NETGEN_SETUP" "$LVS_REPORT"
echo "Inspect $LVS_REPORT for the explicit circuit match/pass result."
