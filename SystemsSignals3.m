%Michael Bentivegna
%Systems & Signals - HW3

clear;
clc;
close all;

%% Question 1:
x1 = linspace(-5,5, 1000);

y1 =3 * (heaviside(x1+2)- heaviside(x1-1));
y2 = exp(x1.*-2) .* heaviside(x1);
y3 = conv(y1, y2, "same") .* .01;

figure(1)
hold on;
plot(x1,y1, 'red')
plot(x1,y2, 'blue')
plot(x1,y3, 'green')
legend('x(t)', 'h(t)', 'y(t) = x(t)*h(t)')
title("Superimposed Graph of Convolution")

%% Question 2:
x = struct();  
h = struct();
y = struct();

x.data = [2 1 0 -1 3];
x.start = -2;
x.name = "x(t)";

h.data = [2 1 3];
h.start = 1;
h.name = "h(t)";

[y.data,y.start] = convol(x,h);
y.name = "y(t) = x(t)*h(t)";

graphStemPlot(x, 1);
graphStemPlot(h, 2);
graphStemPlot(y, 3);

fprintf("Length of x: %d \n" , length(x.data))
fprintf("Support of x: [%d , %d]\n\n" , x.start, x.start + length(x.data) - 1)

fprintf("Length of h: %d \n" , length(h.data))
fprintf("Support of h: [%d , %d]\n\n" , h.start, h.start + length(h.data) - 1)

fprintf("Expected Length of y: %d \n" , length(h.data) + length(x.data) -1)
fprintf("Expected Support of y: [%d , %d]\n\n" , h.start + x.start, x.start + length(x.data)- 1 + h.start + length(h.data) - 1)

fprintf("Actual Length of y: %d \n" , length(y.data))
fprintf("Actual Support of y: [%d , %d]\n\n" , y.start, y.start + length(y.data) - 1)

function domain = graphStemPlot(array, subPlotNum)

    domain = array.start:(length(array.data) + array.start - 1);
    
    figure(2)
    subplot(1,3,subPlotNum)
    hold on;
    stem(domain, array.data)
    title(array.name)
    
end

function [data, start] = convol(array1, array2)

    data = conv(array1.data, array2.data);
    start = array1.start + array2.start;

end

