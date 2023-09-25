function [interval] = get_interval(initial_l, initial_r, target_l, target_r)

interval = [];

if target_l < initial_l
    interval = [
        interval, ...
        (initial_l + 1) : (initial_l + (initial_l - target_l))
    ];
end

interval = [
    interval, ...
    max(initial_l, target_l) : min(initial_r, target_r)
];

if target_r > initial_r
    interval = [
        interval, ...
        (initial_r - 1) : -1 : (initial_r - (target_r - initial_r))
    ];
end