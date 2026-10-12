# Sign-off checklist

- [ ] Detailed routing completes without DRT-0073 or fatal errors.
- [ ] ODB/DEF are from the successful detailed-route run.
- [ ] Extracted SPEF corresponds to the final routed database.
- [ ] Final setup/hold STA is run with that SPEF.
- [ ] Timing slack and TNS are reviewed.
- [ ] Routing DRC report reviewed; required violation count confirmed.
- [ ] PDK/foundry DRC deck run on final layout.
- [ ] Layout-extracted SPICE/CDL netlist generated with the correct technology.
- [ ] Netgen LVS compares layout netlist with trusted reference.
- [ ] LVS report explicitly confirms match.
- [ ] Tool versions, PDK version, commands, and logs archived.
