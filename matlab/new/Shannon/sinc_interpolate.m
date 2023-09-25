function [L] = sinc_interpolate(target_x, idx_list, fx_list)

len = length(idx_list);
L = 0;

for i = 1 : len
    L = L + fx_list(i) * sinc(target_x - idx_list(i));
end