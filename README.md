Project: Interfacing 16x2 LCD with 8051 Microcontroller
1. Project Overview
This project demonstrates the interfacing of a 16x2 Liquid Crystal Display (LCD) with an 8051 microcontroller (AT89C51). The goal is to display a static text string ("Geeta Shahu") on the LCD using assembly language programming. The project includes complete simulation in Proteus, firmware development in Keil µVision, and hardware implementation details.

2. Project Objectives
To understand the working principle of a 16x2 LCD.

To learn the protocol for communicating with HD44780-based LCDs.

To develop assembly code for 8051 to initialize and write to the LCD.

To simulate the circuit in Proteus ISIS.

To implement the circuit on a breadboard with actual components.

3. Components Required
Software Tools:
Keil µVision 5 - IDE for 8051 assembly program development and compiling.

Proteus 8 Professional - For circuit simulation and debugging.

Flash Magic (Optional) - For burning the hex code to the physical microcontroller.

Hardware Components:
AT89C51/52 Microcontroller (or any 8051 variant)

16x2 LCD (HD44780 compatible)

11.0592 MHz Crystal Oscillator

2 × 33pF Ceramic Capacitors

10kΩ Potentiometer (for LCD contrast control)

10μF Electrolytic Capacitor (for Power-On Reset)

10kΩ Resistor (Pull-up for Reset Pin)

330Ω Resistor (Optional, for LCD backlight)

Breadboard and Jumper Wires

5V Power Supply

4. Circuit Diagram (Proteus Simulation)
The circuit is designed and simulated in Proteus ISIS. Key connections:

LCD Pin Connections:
LCD Pin	Symbol	Connection to 8051
1	VSS	Ground (0V)
2	VDD	+5V
3	VEE	Potentiometer Wiper
4	RS	P2.1
5	RW	Ground (0V)
6	E	P2.2
7-14	D0-D7	P1.0 - P1.7
15	A	+5V (via 330Ω)
16	K	Ground
8051 Basic Circuit:
Pin 18-19: Connected to 11.0592 MHz crystal with 33pF capacitors to ground.

Pin 9: Reset circuit (10μF capacitor to VCC, 10kΩ resistor to VCC).

Pin 31 (EA/VPP): Connected to VCC (for using internal ROM).

Pin 40: VCC (+5V), Pin 20: GND.

📁 File Reference: The Proteus design file is located in /Proteus/LCD_Interface_8051.pdsprj

5. Assembly Program (Keil µVision)
Key Routines:
Initialization: Sends commands to set up LCD in 8-bit mode, 2 lines, 5x7 font.

Command Write (COM_WRITE): Sends commands (RS=0) with proper Enable pulse timing.

Data Write (DATA_WRITE): Sends data characters (RS=1) to be displayed.

Delay Routines: Generates necessary delays for LCD processing and power-on reset.

Main Program Flow:
Wait ~15ms for LCD to power up.

Send function set command (0x38).

Turn display on, cursor off (0x0E).

Set entry mode: increment cursor, no shift (0x06).

Clear display (0x01).

Set cursor to first line, first position (0x80).

Read characters from code memory and display them.

Loop until null terminator is found.

📁 File Reference: The source code is located in /Keil/LCD_Interface_8051.asm

6. How to Run the Simulation (Proteus)
Open LCD_Interface_8051.pdsprj in Proteus ISIS.

Ensure the hex file path is correctly set in the microcontroller properties.

Right-click on the AT89C51 → Edit Properties → Program File → Browse to Objects/LCD_Interface_8051.hex

Click the Run Simulation button.

Adjust the potentiometer in the simulation if the display is blank (to set contrast).

7. How to Burn Code to Hardware
Compile in Keil:

Open the project in Keil µVision.

Build the target (F7) to generate the HEX file.

Program the Microcontroller:

Use a programmer (like USBASP, dedicated 8051 programmer, or Flash Magic if using a P89V51RD2) to burn the generated HEX file onto the AT89C51.

Hardware Setup:

Assemble the circuit on a breadboard exactly as shown in the Proteus schematic.

Double-check all power and ground connections.

Connect the LCD's RW pin to Ground.

Connect the potentiometer to LCD's VEE for contrast control.

Apply 5V power.

Troubleshooting:

If the LCD is blank, adjust the potentiometer.

If the display shows garbage, check the timing delays in the code and the control pin connections (RS, E).

Ensure the crystal oscillator is working.

8. Folder Structure
text
8051_LCD_Interface/
│
├── Keil/
│   ├── LCD_Interface_8051.asm   # Main Assembly Source Code
│   ├── LCD_Interface_8051.uvproj # Keil Project File
│   └── Objects/
│       └── LCD_Interface_8051.hex # Compiled Hex File
│
├── Proteus/
│   └── LCD_Interface_8051.pdsprj # Proteus Project File
│
├── Documentation/
│   └── Schematic_Diagram.pdf     # Circuit Schematic
│
└── README.md                     # This file
9. Results
Successful Output: The LCD will display the text on the first line:

text
Geeta Shahu
10. Troubleshooting Common Issues
No Display: Check contrast (adjust potentiometer), check power supply to LCD (VDD, VSS).

Garbage Characters: Check initialization sequence and timing delays in the code. Ensure the RW pin is grounded.

First Row Working, Second Row Not: Check the DDRAM address for the second line (starts at 0xC0).

Simulation not working in Proteus: Ensure the HEX file path in the microcontroller properties is correct.

11. Future Enhancements
Scrolling the displayed text.

Accepting and displaying input from a keypad.

Displaying data from sensors (e.g., temperature using LM35).

Interfacing in 4-bit mode to save GPIO pins.

12. Contributors
Developed by: Geeta Shahu

Guided by: prof. Muhammad Waseem Khanooni Sir

13. References
Datasheet: AT89C51 Microcontroller

Datasheet: HD44780U LCD Controller

Muhammad Ali Mazidi - "The 8051 Microcontroller and Embedded Systems"
