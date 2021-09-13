%Michael Bentivegna
%Homework #7 - Due 4/7/2021

clear;
clc;
close all;

%% Main file:

A = importdata("StocksAll.csv")

symbolArray = A.textdata(1, 2:end);
dateArray = A.textdata(2:end, 1);

DateCellArray = cell(1,length(dateArray)-1);

for i = 1:length(dateArray)-1
   DateCellArray(i) =  {DateClass(dateArray(i + 1))};
end

for i = 1:length(symbolArray)
    graphStock = StockClass(symbolArray(i), DateCellArray, A.data(:,i));
    display(graphStock.plot);
end
