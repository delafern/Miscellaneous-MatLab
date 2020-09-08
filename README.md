# Miscellaneous-MatLab
Random MatLab scripts doing fun things or giving examples of neat functions

Some Examples:
A script developed for Oregon State Rocketry teams to make aluminum or titanium nosecone tips for their rockets.
The user simply fills out the form and the GCODE is automatically generated into a text file which can be interpreted as GCODE by a CNC lathe.
The final product:

![noseconetip](https://github.com/fernancode/Miscellaneous-MatLab/blob/master/nosecone.gif)

Pictured is the input window:
![input](https://github.com/fernancode/Miscellaneous-MatLab/blob/master/screencap2.JPG)


A script to take a random signal (in this case, three superimposed sin waves with different frequencies) and plot the fourier transform to find the dominant frequencies of the signal. This script is largely based on a 3Blue1Brown video but meant for practice in exploring signal processing.
![fourier gif](https://github.com/fernancode/Miscellaneous-MatLab/blob/master/myfile3.gif)


Plotting points from the mandelbrot set - code was a very early attempt and lacking in a lot of ways, BUT was fun to do for someone very new to writing code at the time.
![mbrot](https://github.com/fernancode/Miscellaneous-MatLab/blob/master/screencap1.JPG)

Here I just create a few cylinders and run a simple steady state haet transfer analysis - I believe this was a MATLAB tutorial but I repeated the process with a simple model of a motor I created. The process in question is importing an stl, making a thermal pde, identifying the faces and assigning their thermal conductivity, assigning thermal reservoirs to certain faces, and then solving the pde.
![thermal](https://github.com/fernancode/Miscellaneous-MatLab/blob/master/screencap4.JPG)

Just some stl importing
![STL](https://github.com/delafern/Miscellaneous-MatLab/blob/master/screencap3.JPG)
