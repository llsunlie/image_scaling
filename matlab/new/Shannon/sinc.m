function [res] = sinc(x)

if x == 0
    res = 1;
else 
    res = sin(pi * x) / (pi * x);
end
