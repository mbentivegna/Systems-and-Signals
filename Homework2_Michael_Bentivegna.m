%Michael Bentivegna
%Homework #2 - Due 2/3/2021

clear;
clc;
close all;

%% Question 1:

Vector1A = linspace(0, 2*pi, 100);
Vector1B = linspace(0, 2*pi, 1000);

Function1A = cos(Vector1A./2);
Function1B = cos(Vector1B./2);

Derivative1A = diff(Function1A)./diff(Vector1A);
Derivative1B = diff(Function1B)./diff(Vector1B);

Check1A = -.5*sin(Vector1A./2); 
Check1B = -.5*sin(Vector1B./2);

Difference1A = Check1A(1:end-1) - Derivative1A;
Difference1B = Check1B(1:end-1) - Derivative1B;

MaxDiff1A = max(Difference1A)
MaxDiff1B = max(Difference1B)

%The Vector with 1000 points has a more accurate derivative. 
%This makes sense since the points on the curve are closer.
%Thus they are more similar to the tangent line.

Integral1C = cumsum(Function1A * (2*pi)/100);
Integral1D = cumsum(Function1B * (2*pi)/1000);

Integral1CC = cumtrapz(Vector1A, Function1A);
Integral1DD = cumtrapz(Vector1B, Function1B);

Check1C = 2*sin(Vector1A./2); 
Check1D = 2*sin(Vector1B./2);

Difference1C = Check1C - Integral1C; 
Difference1D = Check1D - Integral1D;
Difference1CC = Check1C - Integral1CC; 
Difference1DD = Check1D - Integral1DD;

MaxDiff1C = max(Difference1C)
MaxDiff1D = max(Difference1D)
MaxDiff1CC = max(Difference1CC)
MaxDiff1DD = max(Difference1DD)
%The Thousand Point Vector Using cumtrapz has the best approximation

plot(Vector1B, Integral1DD)
title('Integral of cos(x/2)')

%% Question 2:

Vector2 = 1:100;
Vector2 = fliplr(Vector2);

A = reshape(Vector2,10,10)
A = flipud(A)
A(4,:) = fliplr(A(4,:)) 

AColumnSum = sum(A,1)
ARowProduct = prod(A,2)
ADiagnol = diag(A)

A(7,:) = []
 
%% Question 3:

%First, Using a Loop Without Preallocation
tic
for i = 1:300
   for j = 1:300
       B(i,j) = 10/((2*pi)*((i-150)^2 + (j-150)^2 + 10^2)^(3/2));
   end
end
toc

%Now, Using a Loop With Preallocation
B = zeros(300,300);
tic
for i = 1:300
   for j = 1:300
       B(i,j) = 10/((2*pi)*((i-150)^2 + (j-150)^2 + 10^2)^(3/2));
   end
end
toc

%Lastly, Using Meshgrid
tic
    A3 = 1:300;
    B3 = 1:300; 
    [i,j] = meshgrid(A3,B3);
    
    F = 10./((2*pi)*((i-150).^2 + (j-150).^2 + 10^2).^(3/2));
    
toc
