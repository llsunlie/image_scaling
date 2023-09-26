function [img2] = cubicBSpline(img1, row_num2, col_num2)

[row_num1, col_num1, c] = size(img1);
img2 = zeros(row_num2, col_num2, c);

% ��չͼ����Ϊ�˺����ֵʱ����Խ��
img1 = [img1;img1(row_num1,:,:);img1(row_num1,:,:)];    %   �ײ���չ���У�ֱ�ӿ������һ��
img1 = [img1(1,:,:);img1];                            %   ������չһ�У�ֱ�ӿ�����һ��
img1 = [img1,img1(:,col_num1,:),img1(:,col_num1,:)];    %   �Ҳ���չ���У�ֱ�ӿ������һ��
img1 = [img1(:,1,:),img1];                            %   �����չһ�У�ֱ�ӿ�����һ��

img1 = double(img1);

x_ratio = col_num1/col_num2;
y_ratio = row_num1/row_num2;

for i = 1 : row_num2
    y  = fix((i-1)*y_ratio) + 2;
    dv = (i-1)*y_ratio - fix((i-1)*y_ratio);
    A  = [weight(-1-dv),weight(-dv),weight(1-dv),weight(2-dv)];
    for j = 1 : col_num2
        x  = fix((j-1)*x_ratio) + 2;
        du = (j-1)*x_ratio - fix((j-1)*x_ratio);
        C  = [weight(-1-du);weight(-du);weight(1-du);weight(2-du)];
        for k = 1 : c
            B = img1(y-1:y+2,x-1:x+2,k);
            img2(i,j,k) = A*B*C;
        end
    end
end
img2 = uint8(img2);

% https://zhuanlan.zhihu.com/p/476659002