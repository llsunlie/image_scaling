function [img2] = bilinear_int(img1,row_num2,col_num2)

[row_num1, col_num1, c] = size(img1);
img2 = zeros(row_num2, col_num2, c);

% ��չͼ����Ϊ�˺����ֵʱ����Խ��
img1 = [img1;img1(row_num1,:,:)];    %   �ײ���չһ�У�ֱ�ӿ������һ��
img1 = [img1,img1(:,col_num1,:)];    %   �Ҳ���չһ�У�ֱ�ӿ������һ��

img1 = double(img1);

x_ratio = floor(col_num1/col_num2*2^16)/2^16;
y_ratio = floor(row_num1/row_num2*2^16)/2^16;

for i = 1 : row_num2
    y  = fix((i-1)*y_ratio) + 1;
    dv = (i-1)*y_ratio - fix((i-1)*y_ratio);
    A  = [1-dv,dv];
    for j = 1 : col_num2
        x  = fix((j-1)*x_ratio) + 1;
        du = (j-1)*x_ratio - fix((j-1)*x_ratio);
        C  = [1-du;du];
        for k = 1 : c
            B  = img1(y:y+1,x:x+1,k);
            img2(i,j,k) = A*B*C;
        end
    end
end
img2 = uint8(img2);