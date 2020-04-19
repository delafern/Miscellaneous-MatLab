function [y,not] = mbrot(x)
%TEST VALUES TO SEE IF THEY PASS INTO MANDELBROT SET
%q = 10; %  #iterations
p = 1000; %precision
m = zeros(1,p); %for speed
for k = 1:p
    m(k+1) = m(k).^2 + x;
end
    if m(p+1)^2 < m(p)^2 && m(p+1) < 2
        y = x;
    else
        y = 0;
    end
end
