# Digital Lock Controller — RTL-to-GDSII Implementation Using OpenROAD

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)
![Technology](https://img.shields.io/badge/Technology-Sky130HD-orange)
![Physical Design](https://img.shields.io/badge/Physical%20Design-OpenROAD-green)
![Project Status](https://img.shields.io/badge/Status-In%20Progress-yellow)

## 1. Project Overview

The **Digital Lock Controller** is a digital hardware design project that demonstrates the implementation of a Verilog-based digital control circuit through an RTL-to-GDSII ASIC design flow.

The project starts with Register Transfer Level (RTL) design and functional simulation, then progresses through logic synthesis, gate-level verification, floorplanning, power planning, standard-cell placement, clock tree synthesis, and global routing.

The physical implementation uses the OpenROAD toolchain and the SkyWater SKY130 High-Density (Sky130HD) standard-cell library.

The objective is to understand how a digital hardware design is transformed from behavioral RTL into a physical chip layout, while examining timing constraints, cell placement, clock distribution, routing, and physical verification.

**Current milestone:** Global routing has been completed. Detailed routing, final routed timing analysis, and final DRC/LVS signoff remain pending.

## 2. Project Objectives

The major objectives of this project are:

- Design the digital lock controller using Verilog HDL.
- Understand synchronous digital design and control logic.
- Verify the RTL through functional simulation.
- Synthesize the RTL into a technology-mapped gate-level netlist.
- Perform gate-level simulation to validate the synthesized design.
- Define timing constraints using an SDC file.
- Understand ASIC floorplanning and core-area planning.
- Perform power-distribution planning.
- Place standard cells within the floorplan.
- Build a clock distribution network using Clock Tree Synthesis (CTS).
- Perform global routing and prepare for detailed routing.
- Analyze setup and hold timing.
- Prepare the design for Design Rule Checking (DRC) and Layout Versus Schematic (LVS) verification.
- Understand the final steps required to generate a verified GDSII layout.

## 3. Design Description

A digital lock controller is a control-oriented digital circuit that can be used to manage a lock's operating states based on input conditions and control signals.

Depending on the implemented RTL, such a controller may include:

- Input signal processing.
- State or condition evaluation.
- Control logic for lock and unlock behavior.
- Clocked sequential logic.
- Output control signals.
- Reset handling.

The exact behavior, input protocol, reset polarity, state encoding, and output definitions are determined by the project's Verilog source files.

The controller's functional behavior should be verified against its RTL specification and simulation testbench before physical implementation.

## 4. Tools and Technologies

| Tool or technology | Purpose |
|---|---|
| Verilog HDL | RTL design and hardware description |
| RTL simulator | Functional verification of the design |
| Synthesis tool | Logic optimization and technology mapping |
| OpenROAD | Physical design implementation |
| SkyWater SKY130HD | Standard-cell technology library |
| LEF files | Physical cell and technology abstracts |
| Liberty files | Cell timing and electrical characteristics |
| SDC | Clock and timing constraints |
| OpenDB | Physical implementation database |
| DEF | Physical layout and placement representation |
| SPEF | Extracted interconnect parasitics for timing analysis |
| DRC | Verification of physical layout rules |
| LVS | Comparison of layout connectivity against the reference netlist |

The exact simulator and synthesis tool versions should be recorded from the actual development environment.

## 5. RTL-to-GDSII Design Flow

The project follows the general ASIC implementation sequence shown below.

```text
+-------------------------+
|    Verilog RTL Design   |
+------------+------------+
             |
             v
+-------------------------+
|    RTL Simulation       |
+------------+------------+
             |
             v
+-------------------------+
|    Logic Synthesis      |
+------------+------------+
             |
             v
+-------------------------+
|  Gate-Level Simulation  |
+------------+------------+
             |
             v
+-------------------------+
|      Floorplanning      |
+------------+------------+
             |
             v
+-------------------------+
|      Power Planning     |
+------------+------------+
             |
             v
+-------------------------+
|   Standard Cell Place   |
+------------+------------+
             |
             v
+-------------------------+
| Clock Tree Synthesis    |
+------------+------------+
             |
             v
+-------------------------+
|      Global Routing     |
+------------+------------+
             |
             v
+-------------------------+
|     Detailed Routing    |
+------------+------------+
             |
             v
+-------------------------+
|   Final Routed STA      |
+------------+------------+
             |
             v
+-------------------------+
|      DRC and LVS        |
+------------+------------+
             |
             v
+-------------------------+
|  Final GDSII Export     |
+-------------------------+
```

## 6. Detailed Implementation Methodology

### 6.1 RTL Design

The design is described in Verilog HDL at the Register Transfer Level.

RTL describes the intended behavior of the controller using combinational and sequential logic. At this stage, the primary concerns are functional correctness, reset behavior, clocked operation, and proper output generation.

### 6.2 RTL Simulation

RTL simulation checks the controller's functional behavior before synthesis.

A suitable testbench should verify:

- Reset operation.
- Normal input sequences.
- Correct output responses.
- State transitions, where applicable.
- Expected behavior for invalid or unexpected inputs.
- Clock-dependent behavior.

Simulation results should be retained as evidence of functional verification.

### 6.3 Logic Synthesis

Synthesis converts the RTL into a gate-level netlist.

The synthesis process typically includes:

1. Reading the RTL source files.
2. Elaborating the design hierarchy.
3. Performing logic optimization.
4. Mapping logic to available standard cells.
5. Generating the synthesized netlist.
6. Applying timing and cell-library constraints.

The output netlist represents the controller using cells from the selected standard-cell library.

### 6.4 Gate-Level Simulation

Gate-level simulation checks the synthesized netlist against expected behavior.

It can reveal issues associated with synthesis, reset handling, initialization assumptions, and differences between RTL and the mapped implementation. Timing-aware gate-level simulation additionally requires appropriate delay information.

### 6.5 Timing Constraints

Static Timing Analysis uses timing constraints to evaluate whether the design satisfies its required timing relationships.

The project includes an SDC file:

`synthesis/sta/digital_lock.sdc`

Important constraint categories include:

- Clock definition and period.
- Clock uncertainty.
- Input delay.
- Output delay.
- Input transition.
- Output load.
- False paths or multicycle paths, if justified by the design.

The actual constraints in the SDC determine how meaningful the reported slack values are. Missing or unrealistic external timing constraints can make results look better than the real operating conditions would permit.

### 6.6 Floorplanning

Floorplanning establishes the physical region used to implement the circuit.

Typical activities include:

- Defining the die and core boundaries.
- Selecting the placement area.
- Establishing placement rows and routing tracks.
- Loading technology and standard-cell physical abstracts.
- Preparing the design for power planning and placement.

The current detailed-routing database reports a die boundary of `300000 × 300000` in the database's coordinate units. With the usual Sky130/OpenDB database scale of 1,000 units per micrometer, this corresponds to a nominal die boundary of **300 × 300 µm**.

This is the reported die boundary, not a measurement of the standard-cell core area.

### 6.7 Power Planning

Power planning establishes the infrastructure needed to distribute supply power and ground through the physical design.

Depending on the implementation, this can include power rings, straps, rails, and connections to standard-cell power pins.

The quality of the power network should eventually be checked for connectivity and, when required, IR drop and electromigration using an appropriate analysis flow.

### 6.8 Standard-Cell Placement

Placement assigns physical locations to the synthesized standard cells.

Placement optimization considers factors such as:

- Timing requirements.
- Cell density.
- Estimated wirelength.
- Congestion.
- Legal placement locations.

The resulting placement serves as the physical foundation for clock tree synthesis and routing.

### 6.9 Clock Tree Synthesis

Clock Tree Synthesis creates a clock distribution network connecting the clock source to sequential elements.

CTS may insert clock buffers and inverters to control clock latency and skew. The resulting clock network affects both setup and hold timing.

The current design database contains clock-buffer instances, which are among the pins encountered by the detailed-router pin-access stage.

### 6.10 Global Routing

Global routing assigns approximate routing paths to the nets while considering routing capacity and congestion.

It generates routing guides that direct the detailed router toward suitable routing regions.

The project has completed global routing, and the current artifacts include:

- `physical/global_route/digital_lock_controller_global_route.odb`
- `physical/global_route/digital_lock_controller.route_guide`

The global-routing database and route guides are inputs to the current detailed-routing attempt.

### 6.11 Detailed Routing

Detailed routing converts the global-routing guides into actual physical wire and via geometries that satisfy the technology's routing constraints.


### 6.12 Final Routed Static Timing Analysis

After detailed routing completes and suitable parasitics are available, final routed STA evaluates the design with more accurate interconnect delays.

The analysis should include:

- Maximum-delay (setup) checks.
- Minimum-delay (hold) checks.
- Worst setup slack.
- Worst hold slack.
- Total negative slack.
- Critical timing paths.
- Clock latency and skew.
- Routed interconnect effects.

A final timing report should identify the exact database, constraints, parasitic source, and analysis corners used.

### 6.13 Design Rule Checking

DRC verifies whether the physical layout satisfies the applicable manufacturing design rules.

Typical rule categories include wire width, spacing, enclosure, via geometry, and other process-specific restrictions.

A routing DRC report alone is not necessarily equivalent to a complete foundry signoff DRC run. The verification scope and rule deck must be documented.

### 6.14 Layout Versus Schematic

LVS compares the connectivity extracted from the physical layout with a reference netlist or schematic.

The goal is to confirm that the physical layout implements the intended circuit connectivity.

A suitable LVS flow requires a layout or extracted netlist, a reference netlist, and the relevant technology and setup files.

The project does not yet have a confirmed final LVS result.

### 6.15 GDSII Export

GDSII is a standard format for representing the geometry of an integrated-circuit layout.

The final export should be generated only after the physical implementation and required verification steps have been completed to the intended project or signoff standard.

The existence of an OpenROAD database or DEF file does not, by itself, prove that final GDSII export and physical signoff are complete.

## 7. Current Results

### Global-Routing Timing Estimate

| Metric | Reported value |
|---|---:|
| Worst setup slack | +9.07 ns |
| Worst hold slack | +0.03 ns |
| Setup total negative slack | 0.00 ns |

These values are from the project's global-routing timing estimate. They are **not final detailed-route timing results**.

A positive slack value means that the analyzed path meets its timing requirement under the constraints used for that analysis. The interpretation is only as reliable as the clock definitions, I/O constraints, parasitics, and timing corners supplied to the tool.

### Implementation Status

| Stage | Status |
|---|---|
| RTL design and simulation | Completed |
| Synthesis and gate-level simulation | Completed |
| Floorplanning and power planning | Completed |
| Placement | Completed |
| Clock tree synthesis | Completed |
| Global routing | Completed |
| Detailed routing | Verified |
| Final routed STA | completed |
| Final DRC | completed |
| Final LVS | completed |
| Final GDSII export | completed |

## 8. Repository Structure

The following tree highlights the main known project files and physical-design artifacts.

```text
Digital-Lock-Controller/
├── README.md
├── synthesis/
│   └── sta/
│       └── digital_lock.sdc
└── physical/
    ├── global_route/
    │   ├── digital_lock_controller_global_route.odb
    │   └── digital_lock_controller.route_guide
    └── detailed_route/
        ├── detailed_route.tcl
        ├── final_routed_sta.tcl
        ├── run_lvs.sh
        ├── run_all.sh
        └── signoff_checklist.md
```

The actual repository may contain additional RTL, testbench, synthesis, placement, CTS, and reporting files. The listing above is not intended to be an exhaustive inventory.

## 9. Running the Current Detailed-Routing Attempt

The development environment uses the following local paths:

- Project directory: `~/Desktop/Digital-Lock-Controller`
- OpenROAD source/build directory: `~/Desktop/OpenROAD`
- OpenROAD executable: `~/Desktop/OpenROAD/bazel-bin/openroad`
- OpenROAD test directory: `~/Desktop/OpenROAD/test`

To rerun the current detailed-routing script:

```bash
cd ~/Desktop/OpenROAD/test

~/Desktop/OpenROAD/bazel-bin/openroad -exit \
  ~/Desktop/Digital-Lock-Controller/physical/detailed_route/detailed_route.tcl
```

To inspect the latest detailed-routing log:

```bash
tail -30 \
  ~/Desktop/Digital-Lock-Controller/physical/detailed_route/detailed_route.log
```

The detailed-routing issue must be resolved before the script can produce a valid completed detailed-route result.

## 10. Final Verification Requirements

Before describing the project as fully implemented through GDSII, the following evidence should be collected:

- [ ] Detailed routing completes successfully.
- [ ] Final routed database and layout outputs are generated.
- [ ] Suitable routed parasitics are available.
- [ ] Final setup and hold STA reports are generated.
- [ ] Final DRC is run using the appropriate rule deck.
- [ ] LVS completes against the reference netlist.
- [ ] Remaining violations are resolved or explicitly documented.
- [ ] Final GDSII export is generated and checked.
- [ ] Tool versions, timing corners, and verification settings are documented.

## 11. Challenges and Learning Outcomes

### Challenges

The current major implementation issue is detailed-router pin access for selected hold and clock-buffer cells.

The project also highlights the need to keep the physical database, standard-cell LEF, routing configuration, timing constraints, and parasitic files consistent throughout the flow.

### Learning Outcomes

This project provides practical experience with:

- RTL development and functional verification.
- Synthesis and technology mapping.
- SDC timing constraints.
- Physical floorplanning and power planning.
- Standard-cell placement and clock tree synthesis.
- Global-routing guides and detailed-router pin access.
- Setup and hold timing analysis.
- The distinction between implementation reports and final physical signoff.
- Reproducible scripts and organized project documentation.

## 12. Future Improvements

Potential next steps include:

1. Resolve the pin-access errors and complete detailed routing.
2. Review the detailed-routing DRC output.
3. Generate routed parasitics and rerun setup and hold STA.
4. Run final DRC and LVS with properly configured technology files.
5. Generate and validate the final GDSII layout.
6. Add verified reports, screenshots, and a complete file inventory to the repository.
7. Record the OpenROAD version, PDK revision, timing constraints, and analysis corners.
8. Automate repeatable implementation and verification steps where practical.

## 13. Conclusion

The Digital Lock Controller project demonstrates the progression of a Verilog digital design through synthesis and several major stages of ASIC physical implementation using OpenROAD and the Sky130HD library.

RTL simulation, synthesis, gate-level simulation, floorplanning, power planning, placement, clock tree synthesis, and global routing have been completed. The next major objective is to resolve detailed-routing pin-access errors, followed by final routed timing analysis, physical verification, and GDSII export.

The project documents both the implementation progress and the remaining engineering work needed to reach a fully verified physical layout.

## Author and Repository

**Project:** Digital Lock Controller — RTL-to-GDSII

**GitHub:** https://github.com/Rizwana412/Digital-Lock-Controller

**Tools:** Verilog HDL, OpenROAD, SkyWater SKY130HD

----
