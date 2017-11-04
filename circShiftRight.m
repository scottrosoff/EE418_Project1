function y = circShiftRight(x,r)
%Shift x (a binary string) to the right r bits with wrap-around
l = length(x);
y=x;
y(r+1:end) = x(1:l-r);
y(1:r) = x(l-r+1:end);

