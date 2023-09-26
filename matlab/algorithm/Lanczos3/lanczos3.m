function [img2] = lanczos3(img1, row_num2, col_num2)
% 
% 参考：
%       https://blog.csdn.net/trent1985/article/details/45150677
%       https://en.wikipedia.org/wiki/Lanczos_resampling


[row_num1, col_num1, c] = size(img1);
img2 = zeros(row_num2, col_num2, c);

% 扩展图像是为了后面插值时避免越界
img1 = [img1; img1(row_num1,:,:); img1(row_num1,:,:); img1(row_num1,:,:);]; %   底部扩展三行，直接拷贝最后一行
img1 = [img1(1,:,:); img1(row_num1,:,:); img1(row_num1,:,:); img1];         %   顶部扩展三行，直接拷贝第一行
img1 = [img1, img1(:,col_num1,:), img1(:,col_num1,:), img1(:,col_num1,:)];  %   右侧扩展三列，直接拷贝最后一列
img1 = [img1(:,1,:), img1(:,1,:), img1(:,1,:), img1];                       %   左侧扩展三列，直接拷贝第一列

img1 = double(img1);

x_ratio = col_num1 / col_num2;
y_ratio = row_num1 / row_num2;

for i = 1 : row_num2
    y = i * y_ratio + 3;
    ry = y - floor(y);
    A = [L(ry + 2), L(ry + 1), L(ry), L(ry - 1), L(ry - 2), L(ry - 3)];
    for j = 1 : col_num2
        x = j * x_ratio + 3;
        rx = x - floor(x);
        B = [L(rx + 2); L(rx + 1); L(rx); L(rx - 1); L(rx - 2); L(rx - 3)];
        for k = 1 : c
            img2(i, j, k) = A * img1(floor(y) - 2 : floor(y) + 3, floor(x) - 2 : floor(x) + 3, k) * B;
        end
    end
end

img2 = uint8(img2);