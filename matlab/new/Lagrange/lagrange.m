function [img3] = lagrange(img1,row_num2,col_num2,sample_count)

[row_num1, col_num1, c] = size(img1);
img1 = double(img1);
img2 = zeros(row_num1, col_num2, c);
img3 = zeros(row_num2, col_num2, c);

x_ratio = col_num1 / col_num2;
y_ratio = row_num1 / row_num2;

half_count = floor(sample_count / 2);

% x 方向缩放
for i = 1 : row_num1
    for j = 1 : col_num2
        x = j * x_ratio;
        idx_l = floor(x) - half_count + 1;
        idx_r = idx_l + sample_count - 1;
        for k = 1 : c
            interval = get_interval(1, col_num1, idx_l, idx_r);
            img2(i, j, k) = calc(x, idx_l:idx_r, img1(i, interval, k));
        end
    end
end

% y 方向缩放
for j = 1 : col_num2
    for i = 1 : row_num2
        y = i * y_ratio;
        idx_l = floor(y) - half_count + 1;
        idx_r = idx_l + sample_count - 1;
        for k = 1 : c
            interval = get_interval(1, row_num1, idx_l, idx_r);
            img3(i, j, k) = calc(y, idx_l:idx_r, img2(interval, j, k));
        end
    end
end
img3 = uint8(img3);

% https://blog.csdn.net/weixin_43219615/article/details/94437196
% https://blog.csdn.net/qq_41718325/article/details/111571604