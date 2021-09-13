%Michael Bentivegna
%Homework #1 - Due 1/27/2021

clear;
clc;
close all;

%% Question 1:

VarOneA = log10(34);
VarOneB = 6*exp(j*(3*pi/4));
VarOneC = atan(sqrt(65)) + 24;
VarOneD = sqrt(3)/2 +.5j;
  
ColumnVector = [VarOneA ; VarOneB ; VarOneC ; VarOneD]
  
%% Question 2:
  
ComplexMult = VarOneB * VarOneD;
RealComponent = real(ComplexMult);
ImagComponent = imag(ComplexMult);
AbsValue = abs(ComplexMult);
AngleValue = angle(ComplexMult);

RowVector = [RealComponent, ImagComponent, AbsValue, AngleValue]

%% Question 3:

Matrix1 = ColumnVector * RowVector

EleMultMatrix = transpose(ColumnVector) .* RowVector;
Matrix2 = repmat(EleMultMatrix, 4, 1)

%% Question 4:

MatrixAdd = Matrix1 + .5 * Matrix2
MatrixEMult = Matrix1 .* Matrix2
MatrixSubConstant = Matrix1 - 2
MatrixConjTranspose = Matrix1'
MatrixEyeAdd = Matrix2 + 3*eye(4)

%% Question 5:

n = rad2deg(AngleValue)

LongVector1 = linspace(1, n, 1500)
LongVector2 = 1:.4 : n


