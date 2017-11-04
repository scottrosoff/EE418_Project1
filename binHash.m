function y = binHash(x)
%Takes in as input a binary string, gives as output a binary string
hexString = hash(x,'SHA-1');
y = convertHexString(hexString);
