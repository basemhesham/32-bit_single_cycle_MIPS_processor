# 32-bit_single_cycle_MIPS_processor
This repository contains the Verilog implementation of a single-cycle MIPS processor. The single-cycle design is a simple and straightforward approach to implementing a MIPS architecture, where each instruction fetch, decode, execute, memory access, and write-back stage is completed within a single clock cycle.

## Project Overview

The goal of this project is to provide a functional and efficient implementation of a single-cycle MIPS processor using Verilog HDL. The processor is designed to execute a subset of the MIPS instruction set architecture (ISA), including key instructions such as arithmetic and logical operations, memory access, branching, and jumping.

## Features

- Single-cycle architecture: The processor follows a single-cycle design, where each instruction is executed within a single clock cycle.
- Instruction set support: The processor supports a subset of the MIPS ISA, allowing for the execution of common instructions used in MIPS assembly programs.
- Modular design: The Verilog code is organized into separate modules for different functional units, such as the instruction fetch, decode, execute, memory, and write-back stages, making it easy to understand and modify.

## MIPS Instructions Supported

The MIPS architecture provides a variety of instructions, and this single-cycle processor implementation supports the following instructions:

1. **lw**: Load Word
   - Syntax: `lw rt, imm(rs)`
   - Description: Loads a 32-bit word from memory into a register.

2. **sw**: Store Word
   - Syntax: `sw rt, imm(rs)`
   - Description: Stores a 32-bit word from a register into memory.

3. **addi**: Add Immediate
   - Syntax: `addi rt, rs, imm`
   - Description: Adds a 16-bit immediate value to the value in a register.

4. **beq**: Branch Equal
   - Syntax: `beq rs, rt, offset`
   - Description: Branches to a target address if the values in two registers are equal.

5. **jal** and **j**: Jump and Jump Register
   - Syntax: `jal target` (for jump and link)
   - Syntax: `j target` (for jump)
   - Description: Jumps to a target address, either with or without saving the return address in a register.

6. **R-type instructions**: Arithmetic and Logical Operations
   - Supported instructions: `add`, `sub`, `slt`, `mul`
   - Description: Performs arithmetic and logical operations on register operands.

## MIPS Operand Diagrams

To better understand the instruction formats for I-type, R-type, and J-type instructions in MIPS, refer to the following diagrams:

1. I-type Operand Diagram:
   ![I-type Operand Diagram] ![I-type](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/b0e721dd-46fc-49dc-87c5-489a17930964)


2. R-type Operand Diagram:
   ![R-type Operand Diagram] ![R-type](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/e119bf58-204f-46cb-8a30-1dc5716892ca)


3. J-type Operand Diagram:
   ![J-type Operand Diagram] ![J-type](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/26ab0c76-1120-48dd-95de-55823b1f83e2)

## Complete Single-Cycle MIPS Processor

The following image represents the schematic diagram of the complete single-cycle MIPS processor:
![Complete Single-Cycle MIPS Processor] ![Complete single-cycle MIPS processor](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/5f56dedd-0686-45e8-a429-2330f72ee35d)

## Contributing

Contributions to this project are welcome. If you find any issues or have suggestions for improvements, please feel free to submit a pull request or open an issue in the repository.

-Refrence: David M. Harris, Sarah L. Harris - Digital Design and Computer Architecture,2ndEdition,2012.

