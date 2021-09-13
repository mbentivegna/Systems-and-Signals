%Michael Bentivegna
%Homework #3 - Due 2/17/2021

clear;
clc;
close all;

%% Question 1:
A = ones(100,100);
B = ones(100,100);
C = ones(100,100);
MappingGrid = 1:100;

[i,j] = meshgrid(MappingGrid)

A(((i-25).^2 + (j-75).^2).^(1/2) < 10) = 0;
A(((i-75).^2 + (j-25).^2).^(1/2) < 10) = 0;

B(((i-25).^2 + (j-25).^2).^(1/2) < 10) = 0;
B(((i-75).^2 + (j-75).^2).^(1/2) < 10) = 0;

C(((i-50).^2 + (j-50).^2).^(1/2) > 10) = 0;

%Making the Dice
D = ones(100,100) - C;
figure(1);
imshow(D)

figure(2); 
imshow(A)

E = ones(100,100);
E(A == 0 | D == 0) = 0;
figure(3); 
imshow(E)

F = ones(100,100);
F(A == 0 | B == 0) = 0;
figure(4); 
imshow(F)

G = ones(100,100);
G(A == 0 | D == 0 | B == 0) = 0;
figure(3); 
imshow(G)
    
%% Question 2:
[value,index] = findThreshold(normpdf(linspace(0,5,100),0,1), 0.05)

%% Question 3:

x = linspace(-5.25,5.25, 9999);
y = sinc(x);        
                               
[zeroCross, localExtrema] = main(x,y);

extract = y(5000:5953);  
%[firstVal, firstInd]= findThreshold(extract,0.2) 

%% Question 2 (continued):

function [val,ind] = findThreshold(x,threshold)
    allThatSatisfy = find(x<threshold);
    ind = allThatSatisfy(1);
    val = x(ind);
end 
