# Digital Lock Controller — Remaining Physical Sign-off Package

Includes scripts/templates for detailed routing, final routed STA, routing DRC report collection, and LVS invocation.

## Important status
Your current log has DRT-0073 pin-access failures for `hold1/A` and three clock-buffer input pins. Until those are resolved and detailed routing finishes, final routed STA and final DRC/LVS sign-off are not complete. This package does not fabricate results.

## Assumptions
Project: `~/Desktop/Digital-Lock-Controller`
OpenROAD: `~/Desktop/OpenROAD/bazel-bin/openroad`
OpenROAD test flow: `~/Desktop/OpenROAD/test`

Edit paths in `run_all.sh` if needed. Run from the extracted folder:
```bash
chmod +x run_all.sh run_lvs.sh
./run_all.sh
```

The wrapper stops on failure. It requires a real extracted routed SPEF for final STA. A global-route parasitic estimate is not final routed STA.

## LVS requirements
LVS needs a real layout-extracted SPICE/CDL netlist, a trusted reference netlist, and a Sky130-compatible Netgen setup file. Set `LAYOUT_SPICE`, `REFERENCE_SPICE`, and `NETGEN_SETUP` before running `./run_lvs.sh`. This package cannot generate genuine DRC/LVS pass results without running the appropriate PDK tools and decks.
