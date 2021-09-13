%Michael Bentivegna
%Homework #3 - Due 2/17/2021

function [zeroCross, localExtrema] = main(x,y)

zeroCross = x(signSwitch(y)); 

dydx = diff(y)./diff(x);
signSwitch(dydx);

xExtrema = x(signSwitch(dydx));  
yExtrema = y(signSwitch(dydx)); 

figure(6);
hold on;
plot(x,y)
plot(zeroCross, 0,'r*', xExtrema, yExtrema, 'ko')

localExtrema = yExtrema

end 

function i = signSwitch(v)

primaryIndex = v(1:end-1); 
secondaryIndex = v(2:end);

i = (primaryIndex < 0 & secondaryIndex > 0) | (primaryIndex > 0 & secondaryIndex < 0); 
i = i + 1; %This makes it the secondary indexes value rather than the primary

end

