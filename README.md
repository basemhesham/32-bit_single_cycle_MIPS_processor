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
  ![I-type](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/b0e721dd-46fc-49dc-87c5-489a17930964)


2. R-type Operand Diagram:
  ![R-type](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/e119bf58-204f-46cb-8a30-1dc5716892ca)


3. J-type Operand Diagram:
   ![J-type](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/26ab0c76-1120-48dd-95de-55823b1f83e2)

## Single-Cycle MIPS Processor diagram

The following image represents the schematic diagram of the complete single-cycle MIPS processor:
![Complete single-cycle MIPS processor](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/5f56dedd-0686-45e8-a429-2330f72ee35d)

Top module view:
![Top Module](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/04d297bd-8eff-4e27-91e1-cd2e2227303e)

## Main modules:
1. ALU : The ALU forms the heart of most computer systems. The 3-bit ALUControl signal specifies the operation. The ALU generates 32-bit ALUResult and a zero flag to indicate if result == 0.
![ALUControl](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/43601d8c-5df2-4207-bed5-f82dea8a2d3d)

2. Program counter: program counter register contains the 32-bit address to execute. The PC is updated at the rising edge of clk and cleared whenever the active low reset is asserted asynchronously.

3. Instruction memory: PC is connected to the address input of the instruction memory. The instruction memory fetches the 32-bit instruction. It is a ROM that holds the program that your CPU will execute. This ROM has width = 32 bits and depth = 256 entries (1KB ROM), i.e, you will only connect bits 9 to 2 in the address bus as it is byte aligned. Instructions are read asynchronously.

4. Register File: The Register file contains the 32 32-bit MIPS registers. The register file has two read output ports (RD1 and RD2) and a single input write port (WD3). The register file is read asynchronously and written synchronously at the rising edge of the clock. The register file supports simultaneous reads and writes. The register file has width = 32 bits and depth = 32 entries. Note that there is a write enable signal that is used to enable writing the new value on the data bus (WD3) to the specified register address (A3).

5. Data memory: It is a RAM that provides a store for the CPU to load from and store to. Reads are asynchronous and writes are synchronous to the rising edge of the clk signal. It is the same width and depth of instruction memory. Note that test_value is read from address 0x0000_0000 (first4 | P a g e location on memory) the least 16 significant bits. This is for testing purposes only

6. Control unit: the control unit computes the control signals based on the
opcode and funct fields of the instrucrion, instr31:26 and instr5:0 . Most of the
control information comes from the opcode, but R-type instructions also use
the funct field to determine the ALU operation. Thus, we will simplify that by
factoring control unit into two blocks: ALU decoder and main decoder
![Control_Unit](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/b1c3fda4-f172-41f5-b989-cd2aa49badca)

ALU decoder truth table:
![ALU decoder truth table](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/842e9a9e-9e71-4946-90f8-d9e6c6e2d9f0)

Main decoder truth table:
![main decoder truth table](https://github.com/basemhesham/32-bit_single_cycle_MIPS_processor/assets/136960296/6b9b4656-7eb2-4c3c-8523-fae5a89c1d24)

7. Small modules:
   
-Sign Extend: Sign extension copies the MSB of a short input
(16 bits) into all the upper bits of the longer output (32 bits).

-Shift_left_twice: you need to make this block parametrized to use in two different versions of data input width.

-Adders and MUXs

## Contributing

Contributions to this project are welcome. If you find any issues or have suggestions for improvements, please feel free to submit a pull request or open an issue in the repository.


-Refrence: David M. Harris, Sarah L. Harris - Digital Design and Computer Architecture,2ndEdition,2012.

