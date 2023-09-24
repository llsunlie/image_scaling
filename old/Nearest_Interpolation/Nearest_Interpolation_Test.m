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
    IMG2 = imresize(IMG1,[h2 w2],'nearest');

    figure
    imshowpair(IMG1,IMG2,'montage');
    title(['��ͼ��ԭͼ', size1, '  ��ͼ��Matlab�Դ�����ڲ�ֵ�Ŵ���', size2]);
    imwrite(IMG2, [PIC_OUTPUT_NAME, '_matlab_nearest', PIC_SUFFIX]);

    % -------------------------------------------------------------------------
    IMG3 = Nearest_Interpolation(IMG1,h2,w2);

    figure
    imshowpair(IMG1,IMG3,'montage');
    title(['��ͼ��ԭͼ', size1, '  ��ͼ���ֶ���д����ڲ�ֵ�Ŵ���(����)', size2]);
    imwrite(IMG3, [PIC_OUTPUT_NAME, '_my_nearest_float', PIC_SUFFIX]);

    % -------------------------------------------------------------------------
    IMG4 = Nearest_Interpolation_Int(IMG1,h2,w2);

    figure
    imshowpair(IMG1,IMG4,'montage');
    title(['��ͼ��ԭͼ', size1, '  ��ͼ���ֶ���д����ڲ�ֵ�Ŵ���(����)', size2]);
    imwrite(IMG4, [PIC_OUTPUT_NAME, '_my_nearest_int', PIC_SUFFIX]);

    % -------------------------------------------------------------------------
    % Generate image Source Data and Target Data
    % Gray2Gray_Data_Gen(IMG1,IMG4);
end
