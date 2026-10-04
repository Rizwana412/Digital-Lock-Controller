# Digital Lock Controller

A digital lock controller implemented in SystemVerilog and synthesized using the SKY130 standard-cell library.

## Flow

RTL
→ Yosys synthesis
→ SKY130 standard-cell mapping
→ Gate-level netlist
→ OpenSTA
→ Setup/Hold timing analysis

## Technology

- PDK: SKY130
- Standard-cell library: sky130_fd_sc_hd
- Timing corner: tt
- Clock period: 10 ns
- Clock frequency: 100 MHz

## Tools

- Yosys
- OpenSTA
- Docker
- SKY130 standard-cell library

## Timing Results

| Metric | Result |
|---|---:|
| Clock period | 10.00 ns |
| Worst setup slack | +9.32 ns |
| Worst hold slack | +0.09 ns |
| Setup | MET |
| Hold | MET |

## Repository Structure

```text
rtl/
    digital_lock_controller.sv

synthesis/
    digital_lock_controller_mapped.v
    sta/
        digital_lock.sdc
        run_sta.tcl
        timing_report.txt


### Step 3 — Push the README

```bash
git add README.md
git commit -m "Document SKY130 synthesis and STA results"
git push
