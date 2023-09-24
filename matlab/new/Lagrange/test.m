clear all; close all; clc;

IMG1 = imread('../imgs/LenaRGB_256x256.bmp');
IMG2 = lagrange(IMG1,512,512,3);

figure
imshowpair(IMG1,IMG2,'montage');
title(['left: original','  ','right: lagrange']);