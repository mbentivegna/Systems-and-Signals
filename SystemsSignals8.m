%Michael Bentivegna
%Systems & Signals - HW8

clear;
clc;
close all;

%% Main

%Part 1 -------------

%Distribution Calculations
N = 1e6;
NormalDist = randn(1, N);

degFreedom = 5;
ScaleFactor = 1/(degFreedom/(degFreedom-2));
TDist = ScaleFactor .* trnd(5, [1, N]);

U = rand([1, N]);
alpha = .544;
CauchyDist = alpha*tan(pi*U);

%Check the fraction of absolute values that are greater than 4
GreaterThan4N = length(find(abs(NormalDist) > 4))/N
GreaterThan4T = length(find(abs(TDist) > 4))/N
GreaterThan4C = length(find(abs(CauchyDist) > 4))/N

%Graphing the Distributions
figure;
plot(NormalDist);
yline(4, '--r');
yline(-4, '--r');
title("Normal Distribution");

figure;
plot(TDist);
yline(4, '--r');
yline(-4, '--r');
title("T Distribution");

figure;
plot(CauchyDist);
yline(4, '--r');
yline(-4, '--r');
title("Cauchy Distribution");

%Part 2 -------------

%Generate filter
n = 1e5;
num = [2 .2 -.84];
den = [1 -.95 .9];
v = randn(1, n);
x = filter(num, den, v);

%Finding the correlation
m0 = 5;
Nlen = 1000;
h = impz(num,den,Nlen);
r = conv(h,flipud(h));
r = r(Nlen:Nlen+m0);

%Part 3 -------------

figure;
zplane(num, den);
title("Pole-Zero Plot H(w)")

%Part 4 -------------

R = toeplitz(r);

%Part 5 -------------

%Eigenvalue calculations and proper ordering
[eigvec, eigval0] = eig(R);
[eigval, idx] = sort(diag(eigval0),'descend');
Q = eigvec(:, idx);

%Part 6 -------------

%Find the PSD both estimated and actual
[s_est, w] = pwelch(x, hamming(512), 256, 512);

h = freqz(num, den, w);
s = abs(h).^2;

%Normalizing
s_est = s_est/mean(s_est);
s = s/mean(s);

%Converting to Decibels
sDB = 10*log10(abs(s));
s_estDB = 10*log10(abs(s_est));

%Graphing
figure;
plot(w/pi, sDB, w/pi, s_estDB);
title("Actual & Estimated PSD");
xlabel("w/\pi");
ylabel("Magnitude (decibels)");
legend({'Actual s', 'Estimate s'});

%Part 7 -------------

AngleOfPole = atan(.821203/.475)
AngleInS = .332031*pi

%Part 8 -------------

%Setting up the proper vectors for toeplitz
verticalAxis = (m0+1):-1:1;
horizontalAxis = (m0+1):1:n;

xV = x(verticalAxis);
xH = x(horizontalAxis);

%Generate A and U matrices
A = toeplitz(xV, xH);
[U, sval, v] = svd(A, 'econ');
sval = diag(sval);

%Part 9 -------------

%Generate the QU matrix and error
QU = abs(Q'*U)
err= QU-eye(m0+1,m0+1);
errmax = max(abs(err(:))) 
