%Michael Bentivegna
%Homework #6 - Due 3/23/2021

clear;
clc;
close all;

%% Question 1:

b1 = [2/5, 1/4, 1/7];
a1 = [1/3, 0, -1/8, 3/2];

[z,p,k] = tf2zp(b1,a1);

Zeros = z
Poles = p

figure;
zplane(z,p)
title('Pole-Zero Plot 1')

[h1, n1] = impz(b1, a1, 50);
figure;
impz(b1, a1, 50)

x1 = (-4/5).^(n1);

figure;
subplot(3,1,1)
stem(n1, x1)
xlim([0, 49])
title('Before Filter')
xlabel('Samples')
ylabel('Impulse Response')

subplot(3,1,2)
y1 = filter(b1, a1, x1);
stem(n1, y1)
xlim([0, 49])
title('After Filter (Using filter function)')
xlabel('Samples')
ylabel('Impulse Response')

subplot(3,1,3)
y2 = conv(x1, h1);
n2 = 0:1:length(y2)-1;
stem(n2, y2)
xlim([0, 49])
title('After Filter (Using manual convolution)')
xlabel('Samples')
ylabel('Impulse Response')

%% Question 2:

z2 = [-1; 1];
p2 = [.9*exp(j*(pi)/2); .9*exp(-j*(pi)/2); .95*exp(j*(5*pi)/12); .95*exp(-j*(5*pi)/12); .95*exp(j*(7*pi)/12); .95*exp(-j*(7*pi)/12)];
k2 = .01;

figure;
zplane(z2,p2)
title('Pole-Zero Plot 2')

[b2,a2] = zp2tf(z2,p2,k2);

[H, w] = freqz(b2, a2, 1024);

Magnitude = 20*log10(abs(H));
Phase = rad2deg(unwrap(angle(H)));

figure;
subplot(2,1,1);
plot(w, Magnitude);
xlim([0 pi]);
xticks([0  pi/4 pi/2 3*pi/4 pi]);
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'});
xlabel("Frequency (radians)");
ylabel("Magnitude (decibels)");
title("Magnitude Response");

subplot(2,1,2);
plot(w, Phase);
xlim([0 pi]);
xticks([0  pi/4 pi/2 3*pi/4 pi]);
xticklabels({'0', '\pi/4', '\pi/2', '3\pi/4', '\pi'});
xlabel("Frequency (radians)");
ylabel("Phase (degrees)");
title("Phase Response");


