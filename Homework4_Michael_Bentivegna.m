%Michael Bentivegna
%Homework #4 - Due 3/2/2021

clear;
clc;
close all;

%Graham Schmidt Orthogonalization
%% Check Functions Non Randomized - Real Vectors (This was for me to test with)
X = zeros(3, 3);
X(:, 1) = [1, 2, 3];
X(:, 2) = [-2, 4, 5];
X(:, 3) = [1, 3, -2];

Y = [2.42, -2.21, 4.43];

OrthNormSet = gramSchmidt(X)
Check = isOrthonormal(OrthNormSet)
ProjVector = orthoProj(Y, OrthNormSet)

%% Check Functions With Randomized Complex Vectors

%Same # of Elements as Vectors
Z1 = rand(3, 3) + j*rand(3,3)
V1 = rand(1, 3) + j*rand(1,3)

OrthoNormRand1 = gramSchmidt(Z1)
Check1 = isOrthonormal(OrthoNormRand1)
RandProj1 = orthoProj(V1, OrthoNormRand1)

%Different # of Elements as Vectors
Z2 = rand(4, 3) + j*rand(4,3)
V2 = rand(1, 4) + j*rand(1,4)

OrthoNormRand2 = gramSchmidt(Z2)
Check2 = isOrthonormal(OrthoNormRand2)
RandProj2 = orthoProj(V2, OrthoNormRand2)

%The Error for the Projection is greater when there are more variables than vectors

%% Gaussians & Sin Graph Orthogonalization
xValues = linspace(0, 2*pi, 100);
sinGraph =sin(xValues);

G = zeros(100, 5);
G(:, 1) = (1/sqrt(2*pi))*exp(-(xValues-0).^2);
G(:, 2) = (1/sqrt(2*pi))*exp(-(xValues-(pi/2)).^2);
G(:, 3) = (1/sqrt(2*pi))*exp(-(xValues-(pi)).^2);
G(:, 4) = (1/sqrt(2*pi))*exp(-(xValues-(3*pi/2)).^2);
G(:, 5) = (1/sqrt(2*pi))*exp(-(xValues-(2*pi)).^2);

figure(1);
hold on;
plot(xValues, sinGraph, xValues, G(:, 1), xValues, G(:, 2), xValues, G(:, 3), xValues, G(:, 4), xValues, G(:, 5))
title("Gaussian Curves and Sin Graph");
legend("sin(x)", "μ = 0", "μ = pi/2", "μ = pi", "μ = 3pi/2", "μ = 2pi");

orthoG = gramSchmidt(G);
projSin = orthoProj(sinGraph, orthoG);

figure(2)
subplot(2,1,1)
plot(xValues, sinGraph, xValues, projSin)
title("Sin vs. Projected Sin Graphs")
legend("sin", "projected sin")

subplot(2,1,2)
plot(xValues, orthoG(:,1), xValues, orthoG(:,2),xValues, orthoG(:,3),xValues, orthoG(:,4),xValues, orthoG(:,5))
title("Orthonormal Gaussian Graphs")
legend("μ = 0", "μ = pi/2", "μ = pi", "μ = 3pi/2", "μ = 2pi")

function outMatrix = gramSchmidt(inputMatrix)

[m, n] = size(inputMatrix);
outMatrix = zeros(m, n);
outMatrix(:, 1) = inputMatrix(:,1);


    for i = 2:n
        V = zeros(m, 1);
       
            for j = 1:i-1
               V = V + conj(dot(inputMatrix(:, i), outMatrix(:, j))).*outMatrix(:, j)./norm(outMatrix(:, j))^2;
            end
        
        outMatrix(:, i) = inputMatrix(:, i) - V;
    end

    for c = 1:n
        outMatrix(:, c) = outMatrix(:, c)./norm(outMatrix(:, c));
    end

end

function check = isOrthonormal(checkMatrix)
[m, n] = size(checkMatrix);
check = 1;
    for i = 1:n-1
        for j= i+1:n
            if abs(conj(dot(checkMatrix(:, i), (checkMatrix(:, j))))) > 1000*eps
                check = 0;
            end
        end
    end
end

function projVector = orthoProj(vector, orthoSet)
    [m, n] = size(orthoSet);
    vector = vector.';
    [p, q] = size(vector);
    
    projVector = zeros(p,q);
    
    for i = 1:n
         projVector = projVector + conj(dot(vector(:,1), orthoSet(:, i))).*orthoSet(:, i);
    end
    
    projVector = projVector.';
end

