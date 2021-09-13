%Michael Bentivegna
%Systems & Signals - HW7

clear;
clc;
close all;

%% Main

%Function Calls
[S, v, B, A] = signal(100, 200, 10, [0, -2, -4], -15);
LL = randomVector(100,10,20);

%To Find Key Values
R = (1/200).*A*transpose(A);

[eigvec, eigval0] = eig(R);
[eigval, idx] = sort(diag(eigval0),'descend');
eigv = eigvec(:, idx);

[U,sval, V] = svd(A);
sval = diag(sval);

%Table of Singular Values
x = 1:100;
figure;
stem(x, sval);
title("Single Value Decomposition Output")
ylabel("Magnitude")
xlabel("Ordered in Greatest to Least")

%SMVDR Check
SMVDRgood(1) = 1./(transpose(S(:,1))*inv(R)*S(:,1));
SMVDRgood(2) = 1./(transpose(S(:,2))*inv(R)*S(:,2));
SMVDRgood(3) = 1./(transpose(S(:,3))*inv(R)*S(:,3));
display(SMVDRgood);

SMVDRrandom = zeros(1,20);
for i = 1:20
    SMVDRrandom(i) = 1./(transpose(LL(:,i))*inv(R)*LL(:,i));
end
medianSMVDRrandom = median(SMVDRrandom)
maxSMVDRrandom = max(SMVDRrandom)

%SMUSIC Check
UL = U(:, 1:3);
Ps = UL*transpose(UL);
Pn = eye(100) - Ps;

SMUSICgood(1) = 1./(transpose(S(:,1))*Pn*S(:,1));
SMUSICgood(2) = 1./(transpose(S(:,2))*Pn*S(:,2));
SMUSICgood(3) = 1./(transpose(S(:,3))*Pn*S(:,3));
display(SMUSICgood);


SMUSICrandom = zeros(1,20);
for i = 1:20
    SMUSICrandom(i) = 1./(transpose(LL(:,i))*Pn*LL(:,i));
end
medianSMUSICRrandom = median(SMUSICrandom)
maxSMUSICRrandom = max(SMUSICrandom)


%Function for proper L's (Columns of S) and A
function [S, v, B, A] = signal(M, N, K, PdB, NoiseVarDB)

    NoiseVar = 10.^(NoiseVarDB./10);
    P = 10.^(PdB./10);
 
    v = sqrt(NoiseVar)*randn(M, N);
    B = zeros(length(P), N);
    
    S = zeros(M, length(P));
    
       for i = 1:length(P)
            L = zeros(1, M);
            randIndex = randperm(M, K);
            L(randIndex) = 1/sqrt(K);
            
            S(:, i) = L;
            
            temp = sqrt(P(i))*randn(1, N);
            B(i, :) = temp;
       end
       
    A = S*B + v;
end

%Function for random test L's as columns of LL
function LL = randomVector(M, K, n)

            LL = zeros(M, n);
            
            for i = 1:n
                 randIndex = randperm(M, K);
                 LL(randIndex, i) = 1/sqrt(K);
            end
end

