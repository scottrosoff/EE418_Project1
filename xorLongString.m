function z = xorLongString(x,y)
n = max(length(x), length(y));
for i=1:n
  if length(x) < i
    z(i) = y(i);
  elseif length(y) < i
    z(i) = x(i);
  else
    if x(i) == y(i)
     z(i) = '0';
    else
     z(i) = '1';
    end
  end
end
