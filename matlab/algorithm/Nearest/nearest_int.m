function [img2] = nearest_int(img1,row_num2,col_num2)

[row_num1, col_num1, c] = size(img1);
img2 = zeros(row_num2, col_num2, c);

x_ratio = floor(col_num1/col_num2*2^16)/2^16;
y_ratio = floor(row_num1/row_num2*2^16)/2^16;

for i = 1 : row_num2
    y = fix((i - 1) * y_ratio) + 1;
    for j = 1 : col_num2
        x = fix((j-1)*x_ratio) + 1;
        for k = 1 : c
            img2(i,j,k) = img1(y,x,k);
        end
    end
end
img2 = uint8(img2);