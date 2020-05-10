function [v_init] = get_v_init(nozzle_d)
    %Fluids project/homework

    %Get a flow to exactly 15m altitude with a starting height of 5m given a nozzle
    %diameter at 60 degrees from the horizontal.
    %kind of a quickly thrown together code, but the strategy is put in a
    %nozzle size - the code then runs a forward euler up to 15m - if the
    %velocity vectory in the y direction is greater than zero, the code starts
    %over and subtracts from the initial velocity. this repeats until required
    %conditions are met. (derivative at 15m for y ~= 0

    v_init = 10; %m/s
    g= 9.81;
    rho = 800; %775-840 kg/m^2
    mdot = rho * v_init * (nozzle_d^2*pi / 4);

    a_y = @(v) g - .2*nozzle_d^2 * v^2 * 1.225/rho; %with gravity, y direction
    altitude = 5;
    timestep = .01;
    target_alt = 15; %target altitude when v_y = 0
    delta = 1; %just a dummy value
    while abs(delta)>.00001
        v_init = v_init + delta/10;
        n=1;
        velocity_y(n) = v_init;
        while sign(velocity_y(n)) == 1
            velocity_y(n+1) = velocity_y(n) - timestep * a_y(velocity_y(n));
            altitude(n+1) = altitude(n) + sind(60)*velocity_y(n+1) * timestep;
            n = n+1;
        end
        delta = target_alt - altitude(length(altitude));
        y = altitude; %save in case we like it
        altitude = 5;
    end
end