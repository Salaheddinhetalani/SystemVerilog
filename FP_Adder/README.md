# Floating Point Adder
An adder for two 32-bit floating point numbers.

## Overall Objective
Design an adder that takes two normalized 32-bit floating point numbers and adds them to give a normalized result while handling  the ‘special’ numbers: zero, positive and negative infinity and ‘Not a Number (NaN)’.

The design is synchronous and the system is sensitive to the positive edge of the clock with an active low asynchronous reset that will set the contents of all registers to 0.

The adder has a ‘ready’ output which is asserted for one clock cycle only. as well as one 32-bit input bus and one 32-bit output bus. When the ‘ready’ signal is asserted, the adder expects the first input on the next clock cycle and the second input on the one after that. The sum is available in the same clock cycle as the ‘ready’ signal. In other words, a new calculation can begin as soon as the previous calculation is complete.

## Design
To add two floating point numbers, it is necessary to adjust one number so that the exponents of the two numbers are the same. So, to do this, the fields of each floating point number (sign, mantissa, exponent) need to be extracted, the implicit leading 1 of the mantissas needs to be restored. 

If the mantissa of a number is shifted left or right, the exponent for that number is decremented or incremented by one, respectively. One of the mantissas needs to be shifted until the exponents of the two floating point numbers are the same. The
mantissas are then added or subtracted, according to the sign bits. The resulting number then has to be normalized.
