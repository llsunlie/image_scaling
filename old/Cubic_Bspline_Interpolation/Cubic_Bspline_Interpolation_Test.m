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
    IMG1 = imread([DIR_PATH, FILE_NAME]);    % ��ȡjpgͼ��
    h1 = size(IMG1,1);          % ��ȡͼ��߶�
    w1 = size(IMG1,2);          % ��ȡͼ����
    size1 = ['(', num2str(h1), '*', num2str(w1), ')'];
    factor = 2;
    h2 = h1 * factor;           % �Ŵ��ͼ��߶�
    w2 = w1 * factor;           % �Ŵ��ͼ����
    size2 = ['(', num2str(h2), '*', num2str(w2), ')'];

    % -------------------------------------------------------------------------
    IMG2 = Cubic_Bspline_Interpolation(IMG1,h2,w2);
    imwrite(IMG2, [PIC_OUTPUT_NAME, '_my_cubic_Bspline', PIC_SUFFIX]);

    figure
    imshowpair(IMG1,IMG2,'montage');
    title(['��ͼ��ԭͼ', size1, '  ��ͼ���ֶ���д����B�����㷨�Ŵ���', size2]);
end