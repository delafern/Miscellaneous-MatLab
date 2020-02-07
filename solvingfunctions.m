%Fernando de la Fuente
%2/13/2018
%find all intersections of two functions over the interval 2<=x<=10

clear
clc
clf

f1 = @(x) 100*exp(-x) - 1 ;
f2 = @(x) sin(pi*x) ;
f3 = @(x) f1(x) - f2(x) ;

fplot(f1,[2,10])
hold on 
fplot(f2,[2,10])
ylim([-2,6])
xlabel('x')
ylabel('y')
title('Intersections')

k=2 ;
n=1;
int=0;

while k <= 10
    test(n) = fzero(f3,k) ;

    k=k+.1 ;
    n=n+1 ;
end

int = uniquetol(test) ;

for k=1:length(int)
    plot(int(k), sin(pi*int(k)),'kx') ;
    fprintf('Intersection at x = %0.4f \n',int(k))
end
