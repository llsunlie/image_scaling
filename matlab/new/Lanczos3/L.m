function [res] = L(x)

a = 2;
res = 0;

if x == 0
    res = 1;
elseif (-a <= x) && (x < a)
    res = a * sin(pi * x) * sin(pi * x / a) / (pi^2 * x^2);
end
