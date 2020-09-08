clear
clc

nums = linspace(0,20,100000);

euler = @(t,f) exp(-2i.*f.*t*pi);
f_t = @(t,f,s,a) a .* sin( (t+s) .* f .* 2*pi);
fun1 = @(t) f_t(t,.25,1,1);
fun2 = @(t) f_t(t,.75,0,1);
fun3 = @(t) f_t(t,.5,0,1);

signal = fun1(nums) + fun2(nums) + fun3(nums);

p = 0.0;
n = 1;

fig = figure;
subplot(1,2,2)
title('frequency vs mean real and imaginary components')
xlabel('frequency')
ylabel('mean')
hold on
grid on
ylim([-1 1])
xlim([0 1])
gif('myfile3.gif','DelayTime',1/60,'frame',fig)

while p<1
    fft = signal .* euler(nums,p);
    subplot(1,2,1)
    plot(fft)
    grid on
    axis equal
    xlim([-4,4])
    ylim([-4,4])
    ylabel('i')
    xlabel('r')
    str = ['f = ', num2str(p)];
    title(str)
    %M1(n) = getframe;
    
    subplot(1,2,2)
    x = mean(real(fft));
    y = mean(imag(fft));
    hold on
    plot(p,x,'.b')
    plot(p,y,'.r')
    %M2(n) = getframe;

    p = p+.001;
    n = n+1;
    gif
end

%movie(M,5)