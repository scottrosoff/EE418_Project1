function s = generateRandomBitString(l)
for i=1:l
  s(i) = num2str(round(rand(1)));
end
