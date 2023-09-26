format_print = 'get_interget(initial_l = %d, initial_r = %d, target_l = %d, target_r = %d) = \n';

% test1
initial_l = 1;
initial_r = 50;
target_l  = -2;
target_r  = 3;

interval = get_interval(initial_l, initial_r, target_l, target_r);
fprintf(format_print, initial_l, initial_r, target_l, target_r);
disp(interval);

% test2
initial_l = 1;
initial_r = 50;
target_l  = 48;
target_r  = 52;

interval = get_interval(initial_l, initial_r, target_l, target_r);
fprintf(format_print, initial_l, initial_r, target_l, target_r);
disp(interval);

% test3
initial_l = 1;
initial_r = 50;
target_l  = 2;
target_r  = 6;

interval = get_interval(initial_l, initial_r, target_l, target_r);
fprintf(format_print, initial_l, initial_r, target_l, target_r);
disp(interval);