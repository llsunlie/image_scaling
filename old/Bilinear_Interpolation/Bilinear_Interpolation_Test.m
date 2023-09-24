clear all; close all; clc;

% -------------------------------------------------------------------------
FILE_META_NAME_LIST = {'BaboonRGB', 'LenaRGB', 'PeppersRGB'};
for i = 1 : 3
    PIC_NAME = [FILE_META_NAME_LIST{i}, '_256x256'];
    PIC_OUTPUT_NAME = [FILE_META_NAME_LIST{i}, '_512x512'];
    % Read PC image to Matlab
    PIC_SUFFIX = '.bmp';
    FILE_NAME = [PIC_NAME, PIC_SUFFIX];
    DIR_PATH = '../imgs/';
    IMG1 = imread([DIR_PATH, FILE_NAME]);    % 读取jpg图像
    h1 = size(IMG1,1);          % 读取图像高度
    w1 = size(IMG1,2);          % 读取图像宽度
    size1 = ['(', num2str(h1), '*', num2str(w1), ')'];
    factor = 2;
    h2 = h1 * factor;           % 放大后图像高度
    w2 = w1 * factor;           % 放大后图像宽度
    size2 = ['(', num2str(h2), '*', num2str(w2), ')'];

    % -------------------------------------------------------------------------
    IMG2 = imresize(IMG1,[h2 w2],'bilinear');

    figure
    imshowpair(IMG1,IMG2,'montage');
    title(['左图：原图', size1, '  右图：Matlab自带双线性插值放大结果', size2]);
    imwrite(IMG2, [PIC_OUTPUT_NAME, '_matlab_bilinear', PIC_SUFFIX]);

    % -------------------------------------------------------------------------
    IMG3 = Bilinear_Interpolation(IMG1,h2,w2);

    figure
    imshowpair(IMG1,IMG3,'montage');
    title(['左图：原图', size1, '  右图：手动编写双线性插值放大结果（浮点）', size2]);
    imwrite(IMG3, [PIC_OUTPUT_NAME, '_my_bilinear_float', PIC_SUFFIX]);

    % -------------------------------------------------------------------------
    IMG4 = Bilinear_Interpolation_Int(IMG1,h2,w2);

    figure
    imshowpair(IMG1,IMG4,'montage');
    title(['左图：原图', size1, '  右图：手动编写双线性插值放大结果（定点）', size2]);
    imwrite(IMG4, [PIC_OUTPUT_NAME, '_my_bilinear_int', PIC_SUFFIX]);

    % -------------------------------------------------------------------------
    % Generate image Source Data and Target Data
    % Gray2Gray_Data_Gen(IMG1,IMG4);
end