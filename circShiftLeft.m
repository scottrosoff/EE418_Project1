function y = circShiftLeft(x,r)
l = length(x);
y = x;
y(1:r) = x(l-r+1:end);
y(r+1:end) = x(1:l-r);
