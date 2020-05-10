%Fluids project/homework

%Get a flow to exactly 15m altitude with a starting height of 5m given a nozzle
%diameter at 60 degrees from the horizontal.
%kind of a quickly thrown together code, but the strategy is put in a
%nozzle size - the code then runs a forward euler up to 15m - if the
%velocity vectory in the y direction is greater than zero, the code starts
%over and subtracts from the initial velocity. this repeats until required
%conditions are met. (derivative at 15m for y ~= 0

%code could probably be faster in a few ways, and it could be refined to
%handle cases where stream never reaches 15meters - you have to always
%overshoot for it to work, but that could be easily handled.

clear
clc

g= 9.81;
rho = 800; %775-840 kg/m^2
nozzle_d = .01 %%.3; % m
v_init = 17; %m/s
mdot = rho * v_init * (nozzle_d^2*pi / 4);

a_y = @(v) g - .2*nozzle_d^2 * v^2; %with gravity, y direction
a_x = @(v) .2*nozzle_d^2 * v^2;

%y stuff
altitude = 5;
velocity_y = v_init;

%x stuff
x = 0;
velocity_x = v_init;

step = .01;

v_at_10 = 1;
while v_at_10>=0
    n=1;
    while altitude(n) <= 15 && sign(velocity_y(n)) == 1
        velocity_y(n+1) = velocity_y(n) - step * a_y(velocity_y(n));
        altitude(n+1) = altitude(n) + sind(60)*velocity_y(n+1) * step;
        velocity_x(n+1) = velocity_x(n) - step * a_x(velocity_x(n));
        x(n+1) = x(n) + velocity_x(n)*step;
        n = n+1;
    end
    v_at_10 = velocity_y(length(velocity_y))
    if v_at_10>=0
        clear velocity_y altitude velocity_x x 
        v_init = v_init-.0001;
        altitude = 5;
        velocity_y = v_init;
        %x stuff
        x = 0;
        velocity_x = v_init;
    end
end

plot(x,altitude,'.k')