#!/usr/bin/env python3
"""
Mandlebrot Plotter
@author Richard White
@version 2014-11-24
"""
from graphics import *

width = 800             # Establish the window width
height = 600            # window height
maxR = 1                # maximum Real value (change to a smaller value to zoom in)
minR = -2               # minumum Real value. Real components is graphed on X-axis
minI = -1.2             # minimum Imaginary value
maxI = minI + (maxR - minR) * (height/width) # Have to calculate maxI based on window scaling
iterations = 32         # We're not recursing to infinity, so this number determines the
                        # the resolution of our image. Higher is better (to the limit of the
                        # pixels, but lower is faster.
blue = "0123456789abcdef"    # Used to determine the value of the blue channel when coloring
                            # pixels that AREN'T in Mandlebrot set.

# set up window
w = GraphWin("Mandlebrot",width, height)
w.setBackground("#000")
for j in range(height): 
    cI = maxI - j * (maxI - minI) / height      # Establish the imaginary value for this pixel
    for i in range(width):
        cR = minR + i * (maxR - minR) / width   # Establish the real value for this pixel
        ZR = cR                                 # Establish real component of Z(0)
        ZI = cI                                 # Establish imaginary component of Z(0)

        # Now iterate to find out if in Mandlebrot set or not
        inSet = True                            # Assume that c IS in the Mandlebrot set
        for k in range(iterations):
            if ZR * ZR + ZI * ZI > 4:           # If Z escapes past 2 (calculated as if
                inSet = False                   # Z-squared becomes greater than 4), then
                break                           # it's not in the Mandlebrot set
            else:
                # Calculate new ZR and ZI for Z(n+1) = Z(n)^2 + c
                oldZR = ZR                      
                ZR = ZR * ZR - ZI * ZI + cR     # Real portion
                ZI = 2 * oldZR * ZI + cI        # Imaginary portion
        if (inSet):
            # print(i, j)
            pass
        else:
            # print("Not in set")
            colorIndex = int(k * 16/iterations) # Find a color index for the blue channel
                                                # based on how many iterations to leave
            color = "#00" + blue[colorIndex]    # Establish color
            w.plot(i, j, color)                 # Plot point based on iterations

pause = input()
