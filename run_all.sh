#!/usr/bin/env bash
set -euo pipefail
PROJECT_ROOT="${PROJECT_ROOT:-$HOME/Desktop/Digital-Lock-Controller}"
OPENROAD_BIN="${OPENROAD_BIN:-$HOME/Desktop/OpenROAD/bazel-bin/openroad}"
OPENROAD_TEST="${OPENROAD_TEST:-$HOME/Desktop/OpenROAD/test}"
ROUTED_SPEF="${ROUTED_SPEF:-}"
export PROJECT_ROOT ROUTED_SPEF
mkdir -p "$PROJECT_ROOT/physical/detailed_route" "$PROJECT_ROOT/physical/signoff"
[[ -x "$OPENROAD_BIN" ]] || { echo "OpenROAD not executable: $OPENROAD_BIN" >&2; exit 2; }
[[ -f "$PROJECT_ROOT/physical/global_route/digital_lock_controller_global_route.odb" ]] || { echo "Global-route ODB missing" >&2; exit 2; }
[[ -f "$PROJECT_ROOT/physical/global_route/digital_lock_controller.route_guide" ]] || { echo "Route guide missing" >&2; exit 2; }
cd "$OPENROAD_TEST"
"$OPENROAD_BIN" -exit "$PROJECT_ROOT/physical/detailed_route.tcl" 2>&1 | tee "$PROJECT_ROOT/physical/detailed_route/detailed_route.log"
[[ -f "$PROJECT_ROOT/physical/detailed_route/digital_lock_controller_detailed_route.odb" ]] || { echo "Detailed-route ODB missing; stopping" >&2; exit 3; }
[[ -n "$ROUTED_SPEF" && -f "$ROUTED_SPEF" ]] || { echo "Set ROUTED_SPEF to a genuine extracted routed SPEF before final STA." >&2; exit 4; }
"$OPENROAD_BIN" -exit "$PROJECT_ROOT/physical/final_routed_sta.tcl" 2>&1 | tee "$PROJECT_ROOT/physical/signoff/final_routed_sta.log"
[[ -f "$PROJECT_ROOT/physical/detailed_route/route_drc.rpt" ]] || { echo "Routing DRC report missing" >&2; exit 5; }
cp "$PROJECT_ROOT/physical/detailed_route/route_drc.rpt" "$PROJECT_ROOT/physical/signoff/route_drc.rpt"
echo "Routing DRC report copied. Run the PDK's full DRC deck and configure/run run_lvs.sh separately."
