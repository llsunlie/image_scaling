function [img3] = newton(img1, row_num2, col_num2, degree)
% 功能：牛顿插值算法
% 描述：
%       先缩放 x 轴方向，再缩放 y 轴方向，边缘采用镜像处理
% 输入：
%       img1: MxNx3 的矩阵
%       row_num2: 目标图像的行数
%       col_num2: 目标图像的列数
%       degree: degree阶差商
% 输出：
%       img3: MxNx3 的矩阵
% 例子：
%       img3 = newton(img1, 1080, 1920, 3);
% 参考：
%       https://www.zhihu.com/tardis/zm/art/614317552?source_id=1005


[row_num1, col_num1, c] = size(img1);
img1 = double(img1);
img2 = zeros(row_num1, col_num2, c);
img3 = zeros(row_num2, col_num2, c);

half_count = floor((degree + 1) / 2);

x_ratio = col_num1 / col_num2;
y_ratio = row_num1 / row_num2;

% x 方向缩放
for i = 1 : row_num1
    for j = 1 : col_num2
        x = j * x_ratio;
        idx_l = floor(x) - half_count + 1;
        idx_r = idx_l + degree;
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
        idx_r = idx_l + degree;
        for k = 1 : c
            interval = get_interval(1, row_num1, idx_l, idx_r);
            img3(i, j, k) = calc(y, idx_l:idx_r, img2(interval, j, k));
        end
    end
end
img3 = uint8(img3);
