function [L] = calc(target_x, idx_list, fx_list)

len = length(idx_list);
L = 0;

for i = 1 : len
    y = fx_list(i);
    l = 1;
    for j = 1 : len
        if i == j
            continue;
        end
        l = l * (target_x - idx_list(j)) / (idx_list(i) - idx_list(j));
    end
    L = L + y * l;
end