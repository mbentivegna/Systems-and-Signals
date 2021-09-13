%Michael Bentivegna
%Systems & Signals - HW5

clear;
clc;
close all;

%% Question 1:
x1 = linspace(0, 20000*2*pi, 1000);

fp=  [12e3,15e3];
fs= [10e3,16e3];
rp= 1.5;
rs= 30;
[n,wn]  = ellipord(2*pi*fp, 2*pi*fs, rp, rs,'s');
[z,p,k]  = ellip(n, rp, rs, wn,'s');
[b,a]  = zp2tf(z,p,k);

figure;
zplane(z,p)

[H, w] = freqs(b, a, x1);

Magnitude = 20*log10(abs(H));
Phase = rad2deg(unwrap(angle(H)));

figure;
subplot(2,1,1);
plot(x1, Magnitude);
ylim([-61, 1])
xlabel("Frequency (Radians)");
ylabel("Magnitude (Decibels)");
title("Magnitude Response Analog Filter");
yline(0, '--')
yline(-1.5, '--')
yline(-30, '--')

subplot(2,1,2);
plot(x1, Phase);
xlabel("Frequency (Radians)");
ylabel("Phase (Degrees)");
title("Phase Response Analog Filter");

%% Question 2:

fp = [12e3,15e3];
fs= [10e3,16e3];
rp= 1.5;
rs= 30; 
fsamp=  40e3;
[nd, wnd] = ellipord(fp/(fsamp/2),fs/(fsamp/2),rp,rs);
[zd,pd,kd]  =ellip(nd,rp,rs,wnd);
[bd, ad]  =zp2tf(zd,pd,kd);

n = filtord(bd, ad)
x2 = linspace(0, 2*pi*20000, 1000);

figure;
zplane(zd,pd)

[Hd, wd] = freqz(bd, ad, 1000);

MagnitudeD = 20*log10(abs(Hd));
PhaseD = rad2deg(unwrap(angle(Hd)));

figure;
subplot(2,1,1);
plot(x2, MagnitudeD);
ylim([-61, 1])
xlabel("Frequency (Radians)");
ylabel("Magnitude (Decibels)");
title("Magnitude Response Digital Filter");
yline(0, '--')
yline(-1.5, '--')
yline(-30, '--')

subplot(2,1,2);
plot(x2, PhaseD);
xlabel("Frequency (Radians)");
ylabel("Phase (Degrees)");
title("Phase Response Digital Filter");
