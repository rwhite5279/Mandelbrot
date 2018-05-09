/**
 * Mandlebrot plotter, version 1
 * Based initially on pseudocode at https://en.wikipedia.org/wiki/Mandelbrot_set#Computer_drawings, 
 * but that pseudocode has errors.
 * Things to understand:
 * + A complex number has the form c = (a + bi), where i = √-1.
 * + A complex number can be mapped onto an x-y coordinate axis, where x = Real part (a) and 
 *     y = Imaginary part (b)
 * + The "Mandelbrot set" is the set of complex numbers for which Z(n+1) = Z(n)^2 + c does not
 *     diverge when iterated from n=0.
 * + So, Mandelbrot set values are the black areas in the initial plot.
 * + Non-Mandelbrot values can be colored based on how many iterations it takes them to diverge
 *     from some value. (Confirm.)
 * @author Richard White
 * @version 2018-05-08
 */

float minR = -2; // minimum Real Value. Graphed on x-axis. 
float maxR = 0.5;    // maximum Real value. Change to a smaller value to zoom in)
float minI = -1;   // minimum Imaginary value, graphed on y-axis
float maxI = 1;    // maximum Imaginary value
int max_iteration = 300;  // Not recursing to infinity, so determines resolution
int Px, Py, x, y, xtemp, i; 
float cI, cR, ZI, ZR, oldZR;
boolean inSet;
int w = 800;
int h = 600;

void setup() {
  size(800,600);    // width, height
  background(0);    // basic black
}

void draw() 
{
  for (int r = 0; r < h; r++)    // for every row of screen pixels
  {
    cI = map(r,0,h,minI,maxI);   // calculate scaled imaginary coordinate from this pixel
    for (int c = 0; c < w; c++)  // ...an for every column of screen pixels
    {
      cR = map(c,0,w,minR,maxR); // calculate scaled real coordinate from this pixel
      ZR = cR;                    // Real component of Z(0)
      ZI = cI;                    // Imaginary comp of Z(0)
      // iterate
      inSet = true;
      for (i = 0; i < max_iteration; i++)
      {
        if (ZR * ZR + ZI * ZI > 2 * 2)
        {
          inSet = false;
          break;
        }
        else 
        {
          oldZR = ZR;
          ZR = ZR * ZR - ZI * ZI + cR;
          ZI = 2 * oldZR * ZI + cI;
        }
      }
      if (inSet)
      {
        // pass
      }
      else
      {
        stroke(255);
        point(c,r);
      }
    }
  }
  save("mandlebrot.png");
  noLoop();
}
