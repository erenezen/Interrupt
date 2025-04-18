# PicoBlaze Interrupts

In this assignment, the goal is to:

- Explain the Call/Return Stack and Interrupt mechanism in PicoBlaze.  
- Write assembly code that:  
  - Enables interrupts,  
  - Triggers interrupts via an output port,   
  - Handles nested interrupts (10 and 32 levels).  
- Implement and simulate the design in Vivado.

## Vivado Integration

- The `interrupt.psm` file is assembled using **Fidex IDE** into a VHDL file (ROM module).
- The `top.vhd` file instantiates:
  - The **kcpsm6** PicoBlaze processor core,
  - The generated **BRAM (VHDL)** file containing the program.
