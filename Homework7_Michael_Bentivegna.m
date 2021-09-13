%Michael Bentivegna
%Homework #7 - Due 4/7/2021

clear;
clc;
close all;

%% Main file:

t = 0:.001:2;

signal = zeros(1, 2001)

for f = 1000:1000:50000
    signal = signal + sin(2*pi*f*t)
end

output = signal

Butterworth = Filter1;
Cheb1 = Filter2;
Cheb2 = Filter3;
Elliptic = Filter4;

AllGraphs(Butterworth, "Butterworth", signal);
AllGraphs(Cheb1, "Chebychev", signal);
AllGraphs(Cheb2, "Chebychev II", signal);
AllGraphs(Elliptic, "Elliptic", signal);


function i = AllGraphs(filter1, name, signal)

n = 1024;
[H,f] = freqz(filter1, n, 100000);

Magnitude = 20*log10(abs(H));
Phase = rad2deg(unwrap(angle(H)));

figure;
subplot(2,1,1);
plot(f, Magnitude);
xlim([0 50000]);
xlabel("Frequency (Hz)");
ylabel("Magnitude (decibels)");
title("Magnitude Response of " + name);

subplot(2,1,2);
plot(f, Phase);
xlim([0 50000]);

xlabel("Frequency (Hz)");
ylabel("Phase (degrees)");
title("Phase Response of " + name);

AppliedFilter = filter(filter1, signal);
Fourier = fft(AppliedFilter, n);
ScaledFourier = fftshift(abs(Fourier))/n;

figure;
plot(f, ScaledFourier)
xlim([0 50000]);
xlabel("Frequency (Hz)");
ylabel("Amplitude");
title("FFT of Signal after " + name + " Filter");

end

