function [img2] = lagrange(img1,row_num2,col_num2,sample_count)

[row_num1, col_num1, c] = size(img1);
img2 = im2double(img1);

x_ratio = col_num1 / col_num2;
y_ratio = row_num1 / row_num2;

half_count = floor(sample_count / 2);

% x 方向缩放
for i = 1 : row_num2
    for j = 1 : col_num2
        x = j * x_ratio;
        idx_l = floor(x) - half_count + 1;
        idx_r = idx_l + sample_count - 1;
        
        for k = idx_l : idx_r

        end
        for k = 1 : c
            L = 0;
            for u = idx_l : idx_r
                y = img1(i,u,k);
                l = 1;
                for v = idx_l : idx_r
                    if v == u
                        continue;
                    end
                    l = l * (x - v) / (u - v);
                end
                L = L + y * l;
            end
            img2(i,j,k) = img2(i,j,k) + L;
        end
    end
end

% y 方向缩放
for j = 1 : col_num2
    for i = 1 : row_num2
        y = i * y_ratio + half_count;
        idx_l = fix(y) - half_count + 1;
        idx_r = idx_l + sample_count - 1;
        for k = 1 : c
            L = 0;
            for u = idx_l : idx_r
                x = img1(u,j,k);
                l = 1;
                for v = idx_l : idx_r
                    if v == u
                        continue;
                    end
                    l = l * (y - v) / (u - v);
                end
                L = L +  x * l;
            end
            img2(i,j,k) = img2(i,j,k) + L;
            img2(i,j,k) = round(img2(i,j,k) / 2);
        end
    end
end

img2 = uint8(img2);

% https://blog.csdn.net/weixin_43219615/article/details/94437196
% https://blog.csdn.net/qq_41718325/article/details/111571604