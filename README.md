# Multimodal Digital Clock
This project consists of a multimodal digital clock that uses a VGA to display four different clock modes depending on user input from a Xilinx Nexys-A7 FPGA
to a desktop monitor. The four modes are changed through the inputs of two switches, which determine which one of the four possible modes is active. Next, 
three buttons are used to set the time, with each one corresponding to either the hours, minutes, or seconds column of the clock. Debouncer-counter was used to 
track how many times each of these buttons were pressed. A 'set' button also exists to map the number of button counts to each of the respective columns. An active-low 
reset is also mapped to the press of a push-button. The instructions for the four modes of the clock are as follows:

`00:` 24-hour clock - first set time, then clock automatically counts to 23:59:59 and then loops back to 00:00:00 continuously.

`01:` 12-hour clock - first set time, then clock automatically counts to 12:59:59 and then loops back to 01:00:00 continuously.

`10:` Stopwatch - Hold down 'set' button, and the clock automatically counts up every second starting from 00:00:00. When 'set' button is released, the time is stopped.

`11:` Timer - first set time, then clock automatically counts down until it reaches 00:00:00, where it stops.

The VGA was a task in and of itself, from counting pixels to determining coordinates of each segment of each seven-segment display for each digit. Once this was 
graphically computed, it was input into the code, and this can be observed in the top_square module. As of now, the color of the display is hardcoded, but this can
be easily input into more switches depending on the binary value of the 12-bit RGB.

Thank you for reading!

Amruth Niranjan
