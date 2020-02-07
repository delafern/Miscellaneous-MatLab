%Fernando de la Fuente
%3/13/2018
%Compute total mass g of rocket components using dot product
%maybe toss in some hecking units

clear
clc

Component = [{'Propellant'};{'Tank Supports'};{'Tank Material'};{'Tile Tank Lining'}];
Density = [0.7;6.8;2.9;4.5];
Volume = [700;150;300;50];
T = table(Component,Density,Volume);
Mass = dot(Density,Volume,2);
T = table(Component,Density,Volume,Mass);

totaldata = {'Total',sum(Density),sum(Volume),dot(Density,Volume)};
T = [T;totaldata]