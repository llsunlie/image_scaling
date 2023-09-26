function [fx] = calc(x, x_list, fx_list)

fx = 0;

len = length(x_list);
t = 1;

for i = 1 : len
    fx = fx + t * f(x_list(1:i), fx_list(1:i));
    t = t * (x - x_list(i));
end