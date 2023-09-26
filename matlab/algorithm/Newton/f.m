function [res] = f(x_list, fx_list)

len = length(x_list);

if len == 1
    res = fx_list(1);
elseif len == 2
    res = (fx_list(2) - fx_list(1)) / (x_list(2) - x_list(1));
else
    res = (f(x_list(2:len), fx_list(2:len)) - f(x_list(1:len-1), fx_list(1:len-1))) / (x_list(len) - x_list(1));
end
