# Bit Blasters: 16x16 FPGA Arcade Shooter

![Poster](poster.png)

## Overview
Bit Blasters is a fast-paced arcade-style shooter built entirely from scratch on an FPGA platform, designed around a custom-built 32-bit Beta CPU. It showcases an integrated system with custom FSM logic, datapath, RAM/ROM access, register file design, ALU operations, and real-time interaction via LED matrix and user input.

---

## System Architecture
The system consists of the following main modules:

- **Custom 32-bit Beta CPU**
- **Finite State Machine (FSM)** for control logic
- **LED Matrix Driver** for rendering graphics
- **Register File** for storing game state
- **ALU with Extended Instructions**
- **ROM & RAM** for game logic and dynamic state
- **User Input (buttons)** for control
- **7-Segment Display** for timer and score

### FSM Control Logic 
The FSM manages the game flow with multiple states:
- **Initialization**: Sets up enemies, resets state
- **Idle**: Listens for player inputs
- **Bullet Logic**: Handles bullet color, movement, and encoding
- **Enemy Wave Logic**: Spawns new enemies upon wave clear
- **Collision Detection**: Checks for valid hits based on bullet color and coordinates
- **Timer Management**: Countdown from 60 seconds using slow clock
- **End Game**: Displays score and halts game

The FSM is designed as a **Mealy machine**, where outputs depend on both the current state and inputs.

### Register File (REGFILE)
- **21 registers**, each 32-bit wide
- Addressed via 5-bit select lines
- Holds player position, bullet data, score, timer, and enemy information
- Encoded data formats for efficient use:
  - **[23:16]**: X position
  - **[15:8]**: Y position
  - **[7:0]**: Color (RGB)

### ALU Design
Three new ALU operations were implemented:

- **Enemy Color Encode (6'b111101)**: Quickly marks enemy as inactive by overwriting color
- **Bullet Color Encode (6'b111110)**: Combines bullet x, y, and color into one word
- **Bullet Y Movement Encode (6'b111111)**: Updates bullet Y only, reducing states

These enhance game responsiveness by reducing FSM transitions and simplifying comparisons.

### RAM & ROM
- **RAM (2048 bits)**:
  - 256 pixels × 3 bits/pixel = 768 bits used for RGB matrix
  - Extra space ensures smooth refresh cycles
- **ROM**:
  - Stores static content: wave data, endgame screen, patterns

### Datapath Components
- Dual-port REGFILE with WE control
- ROM/RAM I/O mapped to screen matrix
- WDSEL multiplexers to combine ROM outputs for enemy configuration
- CU takes inputs from:
  - Clock edges (game timer, animation)
  - User input
  - Enemy and bullet state flags

### LED Matrix Display
- Controlled via WS2812B driver
- Driven from RAM content updated by FSM + CPU logic
- Refresh cycles managed by dedicated slow clock

### UI Interaction
- **7 Buttons**: LEFT, RIGHT, RED, GREEN, BLUE, START, RESET
- **Score/Timer**: 2-digit 7-segment display via decoded register output
- **Matrix**: Player, bullets, and enemies updated in real time

---

## Code & Repo
**Project Repository**: [GitHub Link](https://github.com/Kydinhvan/Computer-Structure-32-bits-CPU-game)

Includes:
- ALU Tester
- FSM Diagrams
- Game prototype code
- Additional custom ALU functions
- LED matrix render logic

---

## Test Coverage
Implemented extensive test cases for ALU, FSM, and memory:
- Absolute Value Logic
- Register Overflow
- Movement boundary checks
- Bullet collision logic
- RAM/ROM refresh verification

All tests validate state transitions and datapath correctness.

---

## Conclusion
Bit Blasters demonstrates an end-to-end FPGA game built with a fully custom CPU, FSM, and visual output. With optimizations in ALU encoding, memory utilization, and FSM logic, the system balances performance and modularity while delivering an interactive gameplay experience on real hardware.
