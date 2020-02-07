%Fernando de la Fuente

% plot function and create a legend with string functions
% also highlight of declaring function using DisplayName feature for
% automatic association of line color, legend marker, and data.

clf
clear


for n = 1:5
    k = -1 + 2*n ;
    y = @(x) k.*sin(x) + 2.*(x.^2) ;
    fplot(y,[0 5],'DisplayName',['a is ', num2str(k)] )
    hold on
   
end
legend show 
legend('Location','northwest')
xlabel('x')
ylabel('y')