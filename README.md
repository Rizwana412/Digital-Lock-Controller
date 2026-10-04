# Digital Lock Controller

## 1. Project Overview

The **Digital Lock Controller** is a SystemVerilog-based digital security system designed to demonstrate the basic operation of a password-controlled electronic lock.

The controller receives a digital input representing a password/key entry and compares it with the expected value. Based on the entered value, the controller produces an appropriate output:

- A **correct input** activates the `unlock` signal.
- An **incorrect input** activates the `alarm` signal.
- The controller can be returned to its initial condition using the `reset` signal.

This project demonstrates a complete basic RTL design flow, from writing the SystemVerilog hardware description through simulation, waveform analysis, synthesis, and GitHub-based project documentation.

---

## 2. Objectives

The main objectives of this project are:

1. Design a digital lock controller using SystemVerilog.
2. Create a testbench to verify the RTL behavior.
3. Simulate the design using Icarus Verilog.
4. Analyze simulation waveforms using GTKWave.
5. Test both correct and incorrect input conditions.
6. Synthesize the RTL using Yosys.
7. Obtain synthesis statistics and cell information.
8. Maintain the complete project using Git and GitHub.
9. Document the design, verification results, waveforms, and synthesis results.

---

## 3. Design Description

The Digital Lock Controller contains input and output signals used to control and monitor the lock.

### Main Signals

| Signal | Description |
|---|---|
| `clk` | Clock signal used for synchronous operation |
| `reset` | Resets the controller to its initial state |
| `digit` | Digital input representing the entered value |
| `enter` | Indicates that an input value has been entered |
| `unlock` | Indicates that the correct input has been detected |
| `alarm` | Indicates that an incorrect input has been detected |

The exact implementation and signal behavior are defined in:

```text
rtl/digital_lock_controller.sv
```

---

## 4. Functional Operation

The basic operation of the controller is:

```text
                 +----------------------+
                 | Digital Lock         |
                 | Controller           |
                 +----------+-----------+
                            |
             +--------------+--------------+
             |                             |
       Correct Input                 Incorrect Input
             |                             |
             v                             v
       +-----------+                 +-----------+
       |  UNLOCK   |                 |  ALARM    |
       | Activated |                 | Activated |
       +-----------+                 +-----------+
```

The `reset` input returns the controller to its initial condition.

---

## 5. RTL Implementation

The RTL design is written in **SystemVerilog**.

Main RTL file:

```text
rtl/digital_lock_controller.sv
```

The RTL describes the hardware behavior of the digital lock controller and is used for both simulation and synthesis.

---

## 6. Verification

A SystemVerilog testbench was created to verify the controller.

Main testbench:

```text
tb/digital_lock_controller_tb.sv
```

A second verification testbench is also included:

```text
tb/digital_lock_controller_tb_2.sv
```

### Test Case 1 — Correct Input

The testbench applies the expected input value to the controller.

Expected behavior:

```text
Correct input → unlock activated
```

Result:

```text
PASS
```

### Test Case 2 — Incorrect Input

The testbench applies an incorrect input value.

Expected behavior:

```text
Incorrect input → alarm activated
```

Result:

```text
PASS
```

The testbench also produces simulation messages to indicate whether the expected behavior occurred.

---

## 7. Simulation

Simulation was performed using **Icarus Verilog**.

The RTL and testbench were compiled using SystemVerilog support and then executed to generate the simulation results.

The simulation produced VCD waveform files that can be inspected using GTKWave.

---

## 8. GTKWave Analysis

The generated VCD files were analyzed using **GTKWave**.

The important signals observed during simulation include:

- `clk`
- `reset`
- `digit`
- `enter`
- `unlock`
- `alarm`

Two waveform cases were generated and saved.

The `waveforms/` directory contains both simulation data and visual waveform screenshots.

```text
waveforms/
├── digital_lock_controller.vcd
├── digital_lock_controller_2.vcd
├── waveform_1.png
└── waveform_2.png
```

The `.vcd` files contain the actual simulation waveform data.

The `.png` files provide visual screenshots of the GTKWave results for easy viewing in the GitHub repository.

---

## 9. Synthesis

RTL synthesis was performed using **Yosys**.

The synthesis report is available in:

```text
synthesis/synthesis_report.txt
```

A summary of the synthesis results is also provided in:

```text
synthesis/README.md
```

### Synthesized Cell Summary

| Cell Type | Count |
|---|---:|
| `$adffe` — flip-flop/register logic | 2 |
| `$eq` — equality/comparison logic | 1 |
| `$mux` — multiplexer logic | 2 |
| **Total reported cells** | **5** |

These results represent the logic cells reported by the Yosys synthesis flow for the current RTL implementation.

---

## 10. Project Directory

The repository is organized as follows:

```text
Digital-Lock-Controller/
│
├── README.md
│
├── rtl/
│   └── digital_lock_controller.sv
│
├── tb/
│   ├── digital_lock_controller_tb.sv
│   └── digital_lock_controller_tb_2.sv
│
├── sim/
│
├── waveforms/
│   ├── digital_lock_controller.vcd
│   ├── digital_lock_controller_2.vcd
│   ├── waveform_1.png
│   └── waveform_2.png
│
├── synthesis/
│   ├── synthesis_report.txt
│   └── README.md
│
└── docs/
```

---

## 11. Tools Used

| Tool | Purpose |
|---|---|
| SystemVerilog | RTL design and verification |
| Icarus Verilog | RTL simulation |
| GTKWave | Waveform visualization |
| Yosys | RTL synthesis |
| Git | Version control |
| GitHub | Project hosting and documentation |

---

## 12. Design Flow

The complete project follows this flow:

```text
System Requirement
        ↓
SystemVerilog RTL
        ↓
Testbench Development
        ↓
RTL Simulation
        ↓
VCD Waveform Generation
        ↓
GTKWave Analysis
        ↓
Verification
        ↓
Yosys Synthesis
        ↓
Synthesis Report
        ↓
GitHub Documentation
```

---

## 13. Verification Status

The current implementation has been simulated successfully.

### Current results

- RTL compilation: **PASS**
- Simulation: **PASS**
- Correct-input test: **PASS**
- Incorrect-input test: **PASS**
- GTKWave analysis: **COMPLETED**
- Waveform VCD files: **GENERATED**
- Waveform PNG screenshots: **ADDED**
- Yosys synthesis: **COMPLETED**
- Synthesis report: **GENERATED**
- GitHub repository: **UPDATED**

---

## 14. Future Improvements

Possible future improvements to the project include:

- Supporting a multi-digit password sequence.
- Adding a configurable password.
- Implementing a dedicated finite-state-machine architecture.
- Adding a limited number of password attempts.
- Implementing a lockout period after repeated incorrect attempts.
- Adding additional SystemVerilog assertions.
- Performing technology-mapped synthesis with a standard-cell library.
- Performing detailed static timing analysis.
- Adding automated regression tests.
- Adding FPGA implementation and hardware testing.

---

## 15. Conclusion

The Digital Lock Controller demonstrates a complete introductory RTL development workflow.

The project covers RTL design, functional verification, simulation, waveform analysis, synthesis, and version-controlled documentation.

The repository contains the source code, testbenches, waveform files, waveform screenshots, and synthesis reports required to reproduce and review the project results.

---

## Author

**Digital Lock Controller — SystemVerilog RTL Project**

Developed as an RTL design and verification project demonstrating the digital design flow from specification through synthesis and documentation.
