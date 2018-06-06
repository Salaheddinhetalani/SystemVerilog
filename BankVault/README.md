# Electronic Combination Lock Controller
A SystemVerilog description of a state machine of an electronic emulation of a mechanical rotary combination lock to be synthesised to a Field Programmable Gate Array. 

![screenshot from 2018-06-06 05 09 59](https://user-images.githubusercontent.com/28307467/41013762-fddc1692-6947-11e8-827b-a5c66ddc925d.png)

## Overall Objectives
- Simulate the hardware description of a moderately complex state machine using Modelsim.
- Synthesise a SystemVerilog description to an FPGA using Altera Quartus.
- Program an FPGA and test an FPGA design using an Altera DE1-SoC FPGA Development Board.

## Specifications
The state machine is a controller for an electronic combination lock (Figure 1) and the FPGA is Altera Cyclone V on the Altera DE1-SoC Development Board (Figure 2).
The design is a synchronous state machine that uses the rising edge of the clock, and has an asynchronous active low reset.

![screenshot from 2018-06-06 04 55 45](https://user-images.githubusercontent.com/28307467/41013357-18d9eafc-6946-11e8-98a8-785336ddc655.png)
![screenshot from 2018-06-06 04 55 20](https://user-images.githubusercontent.com/28307467/41013362-1fa62daa-6946-11e8-91b5-f33e7514eb85.png)

## Design
Figure 3 shows the ASM chart for the controller of the initial version of the electronic lock, where the unlocking algorithm is as the following:

1. Resetting the state machine with an active low pulse.
2. Turning the encoder anticlockwise until 0 is reached. The 5-bit position of the encoder is displayed on the LEDs 5 to 9.
3. Turning the encoder clockwise and stopping at the first number of the 5-bit vault code combination, which is 7 or 5’b00111.
4. The vault unlocks. LED 3 lights up when the machine enters the state ‘unlocked’.

![screenshot from 2018-06-06 05 00 17](https://user-images.githubusercontent.com/28307467/41013517-a1107648-6946-11e8-847d-8f6e3c8491e0.png)

While the vault controller actually implements the following extended version of the unlocking algorithm such that the combination consists of three numbers, e.g. 7, 3 and 22:

1. Resetting the state machine.
2. Turning the encoder anticlockwise until reaching 0.
3. Turning the encoder clockwise and stopping at 7 (shown on LEDs 5 to 9).
4. Turning the encoder anticlockwise and stopping at 3.
5. Turning the encoder clockwise and stopping at 22.
6. The vault unlocks and LED 3 is on.

After simulating the entire design in ModelSim to verify that the controller operates correctly, noting that the FPGA is clocked at 50MHz on the DE1-SoC board, as well as synthesizing the design in Quartus.
Now testing can be done by connecting the Altera DE1-SoC board to the encoder using GPIO0 expansion bus and the necessary connectors (Figure 4). The connections must correspond with the encoder pinout shown in Figure 5 and the signals specified in the file vault_pin_assignment.qsf.

![screenshot from 2018-06-06 05 06 05](https://user-images.githubusercontent.com/28307467/41013695-a00ddf8c-6947-11e8-83e3-011eb2bd2b57.png)

![screenshot from 2018-06-06 05 06 13](https://user-images.githubusercontent.com/28307467/41013696-a02e3b9c-6947-11e8-8089-ff63576ae157.png)

The pin assignments also connect the active low asynchronous reset signal n_reset to the push button KEY0 and the controller’s LED outputs to the LED array as well as the controller's 7-segment LED displays outputs to the 7-segment LED displays pins on the Altera Board. 
Noting that the 7-segment displays are used to display more information about the code, the state and the direction of rotating.


*Note: This project was part of the Laboratory of the Digital System Design Module, University of Southampton*
