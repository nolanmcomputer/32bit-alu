# 32-bit Gate-Level ALU in Verilog

A 32-bit Arithmetic Logic Unit (ALU) implemented in Verilog using primarily **gate-level / structural modeling**.

The project builds the ALU from smaller reusable components, including a 1-bit full adder, 32-bit ripple-carry adder/subtractor, logic unit, multiplexers, and shifter. With the exception of the shifter, the datapath is implemented primarily using Verilog gate primitives rather than behavioral arithmetic or logic expressions.

This project was originally developed as a computer architecture coursework project and was later cleaned up for use as a portfolio example.

## Features

The ALU supports four function classes:

| `Function_class` | Operation |
|---|---|
| `00` | Shift |
| `01` | Set Less Than |
| `10` | Arithmetic |
| `11` | Logic |

Additional control signals select the specific operation within each function class.

### Arithmetic

The arithmetic unit supports:

- 32-bit addition
- 32-bit subtraction
- Ripple-carry propagation
- Two's-complement subtraction using conditional inversion of operand `B`

`c_0` controls the arithmetic operation:

| `c_0` | Operation |
|---|---|
| `0` | `A + B` |
| `1` | `A - B` |

The subtraction circuit implements:

```text
A - B = A + ~B + 1
```

Each bit of `B` is XORed with `c_0`, while `c_0` is also used as the initial carry input.

## Logic Unit

The logic unit operates independently on all 32 bits.

| `Logic_function` | Operation |
|---|---|
| `00` | AND |
| `01` | OR |
| `10` | XOR |
| `11` | NOR |

Each bit is implemented using primitive gates and a gate-level 4-to-1 selection circuit.

## Shifter

The shifter supports:

- Logical left shift
- Logical right shift
- Constant shift amount
- Variable shift amount

Shift direction:

| `shift_direction` | Operation |
|---|---|
| `0` | Logical right |
| `1` | Logical left |

Shift amount selection:

| `Const_Var` | Shift amount |
|---|---|
| `0` | `Const_amount` |
| `1` | `A[4:0]` |

Only the least-significant five bits are required because a 32-bit value requires shift amounts from 0 to 31.

The shifter is the one portion of the project intentionally implemented using dataflow modeling:

```verilog
assign shifted_y =
    (shift_direction == 1'b1)
        ? y << amount
        : y >> amount;
```

## Set Less Than

The ALU contains a signed Set Less Than operation.

The implementation performs:

```text
A - B
```

and uses the operand signs together with the subtraction result to determine whether:

```text
A < B
```

for signed 32-bit values.

The comparison accounts for the case where `A` and `B` have different signs rather than relying exclusively on the sign bit of the subtraction result.

The output is:

```text
00000000 00000000 00000000 00000001
```

when `A < B`, and zero otherwise.

## Architecture

The ALU is constructed hierarchically:

```text
                         +----------------+
 A[4:0] ---------------->|                |
 Const_amount ---------->|    Shifter     |----+
 Const_Var ------------->|                |    |
 B --------------------->|                |    |
                         +----------------+    |
                                               |
                                               | 00
                         +----------------+    |
 A --------------------->|                |    |
 B --------------------->|  Signed SLT    |----+
                         |                |    |
                         +----------------+    | 01
                                               |
                                               v
                         +----------------+  +------------+
 A --------------------->|                |  |            |
 B --------------------->|  Adder / Sub   |->|  4-to-1    |----> S
 c_0 ------------------->|                |  |    MUX     |
                         +----------------+  |            |
                                            +------------+
                         +----------------+       ^
 A --------------------->|                |       |
 B --------------------->|   Logic Unit   |-------+
 Logic_function -------->|                |       11
                         +----------------+

                                  Arithmetic = 10
```

The final 32-bit multiplexer selects among:

```text
00 -> Shifter
01 -> Set Less Than
10 -> Arithmetic
11 -> Logic
```

## Module Hierarchy

### `fulladd`

A structural 1-bit full adder built from primitive gates.

Inputs:

```text
a
b
carry-in
```

Outputs:

```text
sum
carry-out
```

The circuit implements:

```text
sum  = A XOR B XOR Cin
Cout = (A AND B) OR (Cin AND (A XOR B))
```

### `adder_sub`

A 32-bit ripple-carry adder/subtractor composed of 32 instances of `fulladd`.

```text
fulladd[0]
    |
 carry
    v
fulladd[1]
    |
 carry
    v
   ...
    |
 carry
    v
fulladd[31]
```

No Verilog `+` or `-` operator is used to perform the arithmetic datapath operation.

### `logic1bit`

Implements one bit of:

```text
AND
OR
XOR
NOR
```

and selects the result using gate-level multiplexing.

### `logic_unit`

Creates the 32-bit logic datapath by instantiating 32 `logic1bit` modules.

### `mux4_1_1bit`

Gate-level 4-to-1 multiplexer.

### `mux32bit`

32-bit output multiplexer constructed from 32 instances of the 1-bit multiplexer.

### `shifter`

Performs logical left or right shifts.

Unlike the remainder of the ALU datapath, this module uses dataflow modeling for the shift operation.

### `ALU_32bits`

Top-level module connecting all datapath components and control signals.

## Top-Level Interface

```verilog
module ALU_32bits(
    output [31:0] s,
    input  [31:0] a,
    input  [31:0] b,
    input         c_0,
    input         Const_Var,
    input         shift_direction,
    input  [1:0]  Function_class,
    input  [1:0]  Logic_function,
    input  [4:0]  Const_amount
);
```

### Inputs

| Signal | Width | Description |
|---|---:|---|
| `a` | 32 | First operand |
| `b` | 32 | Second operand / shift input |
| `c_0` | 1 | Add/subtract control |
| `Const_Var` | 1 | Constant/variable shift selector |
| `shift_direction` | 1 | Logical shift direction |
| `Function_class` | 2 | Selects major ALU operation |
| `Logic_function` | 2 | Selects logic operation |
| `Const_amount` | 5 | Constant shift amount |

### Output

| Signal | Width | Description |
|---|---:|---|
| `s` | 32 | ALU result |

## Gate-Level Modeling

A major goal of the project is to model the datapath structurally rather than describing the desired result behaviorally.

For example, the full adder is implemented using primitive gates:

```verilog
xor(s1, a, b);
and(c1, a, b);

xor(sum1, s1, c);
and(c2, s1, c);

or(cout, c2, c1);
```

Likewise, a 4-to-1 multiplexer is constructed as:

```verilog
not(ns1, s1);
not(ns0, s0);

and(w0, i0, ns1, ns0);
and(w1, i1, ns1, s0);
and(w2, i2, s1, ns0);
and(w3, i3, s1, s0);

or(out, w0, w1, w2, w3);
```

This makes the underlying digital circuit visible in the Verilog implementation rather than allowing synthesis software to infer the entire datapath from high-level operators.

## Testing

Each major component was tested independently before integration into the complete ALU.

The project contains testbenches for:

- 1-bit full adder
- 32-bit adder/subtractor
- shifter
- logic unit
- 32-bit multiplexer
- complete ALU

Example arithmetic cases include:

```text
5 + 4 = 9
6 - 2 = 4
```

Logic tests cover all four logic functions:

```text
AND
OR
XOR
NOR
```

The complete ALU testbench exercises multiple function classes and control combinations.

## Simulation

The design can be simulated using tools such as Icarus Verilog.

Compile:

```bash
iverilog -o alu_sim alu.v
```

Run:

```bash
vvp alu_sim
```

For testbenches:

```bash
iverilog -o alu_sim src/*.v tb/alu_tb.v
vvp alu_sim
```

For example:

```verilog
initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, stimulus);
end
```

Then:

```bash
gtkwave alu.vcd
```

## Repository Structure

```text
verilog-32bit-alu/
├── README.md
├── src/
│   ├── full_adder.v
│   ├── adder_sub.v
│   ├── shifter.v
│   ├── logic_unit.v
│   ├── mux4_1.v
│   └── alu_32bits.v
│
└── tb/
    ├── full_adder_tb.v
    ├── adder_sub_tb.v
    ├── shifter_tb.v
    ├── logic_unit_tb.v
    ├── mux_tb.v
    └── alu_tb.v
```

## Design Notes

This project intentionally favors explicit structural implementation over concise Verilog.

For example, the 32-bit adder explicitly instantiates each stage of the ripple-carry chain rather than using:

```verilog
assign result = a + b;
```

Similarly, the logic and output-selection circuits are constructed from gates and reusable 1-bit modules.

Although considerably more verbose, this approach demonstrates:

- combinational logic design
- Boolean gate composition
- ripple-carry arithmetic
- two's-complement subtraction
- hierarchical hardware design
- multiplexing
- signed comparison
- structural Verilog
- module integration
- testbench-based verification

## Background

This project was developed as part of coursework in Computer Architecture.

The assignment required the ALU to be implemented primarily with **gate-level modeling**, with dataflow modeling permitted for the shifter. Each component was designed and tested independently before being connected into the complete 32-bit ALU.

The repository has been cleaned up and documented as a demonstration of low-level digital design and Verilog experience.
