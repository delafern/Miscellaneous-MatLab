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
nozzle_d = .2; %%.3; % m
v_init = 10; %m/s
mdot = rho * v_init * (nozzle_d^2*pi / 4);

a_y = @(v) g - .2*nozzle_d^2 * v^2 * 1.225/g; %with gravity, y direction
a_x = @(v) .2*nozzle_d^2 * v^2;

%y stuff
altitude = 5;
velocity_y = v_init;

%x stuff
x_dir = 0;
velocity_x = v_init;

step = .01;
target_alt = 15;
delta = 1;

while abs(delta)>.001
    n=1;
    velocity_y(n) = v_init;
    while sign(velocity_y(n)) == 1
        velocity_y(n+1) = velocity_y(n) - step * a_y(velocity_y(n));
        altitude(n+1) = altitude(n) + sind(60)*velocity_y(n+1) * step;
        velocity_x(n+1) = velocity_x(n) - step * a_x(velocity_x(n));
        x_dir(n+1) = x_dir(n) + velocity_x(n)*step;
        n = n+1;
    end
    delta = target_alt - altitude(length(altitude));
    y = altitude; %save in case we like it
    x = x_dir; %same as above
    x_dir = 0;
    altitude = 5;
    v_init = v_init + delta/10;
end
v_init
plot(x,y,'.k')
