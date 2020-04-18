%Fernando de la Fuente
%Mandelbrot Set Attempt no.5
%evaluate points in the mandelbrot set
%to-do - find ways to speed this guy up, evaluate a bunch more points
%This was one of the first codes I wrote  - very proudly generated a plot resembling the mandelbrot set. Obviously there are other coding languages which would be preferable for doing this in terms of speed and graphics handling.
clc
clear
hold on


a=500; %bump
b=500;
c = zeros(a*b,1);
k = 1;

for x = linspace(-2,1,a)
    for y = linspace(-2i,2i,b)
        z= x+y;
        [i] = mbrot(z) ;
        c(k,:) = i;
        k = k + 1 ;
     end
end

c = unique(c);
plot(c,'.k','MarkerSize',1)
xlim([-2 1])
axis equal
grid on
hold on


%next step add a color/distance from 2 factor/ITERATION DISTANCE COLOR
%try loading a figure, not clearing it, and adding more tiny and tiny
%intervals?
