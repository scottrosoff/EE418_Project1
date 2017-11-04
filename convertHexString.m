function y = convertHexString(x)
%Converts a long hexidecimal string to binary
y = [];
for i=1:length(x)
  y = [y dec2bin(hex2dec(x(i)),4)];
end
