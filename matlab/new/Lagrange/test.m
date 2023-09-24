IMG1 = imread('../imgs/original/256x256/LenaRGB.bmp');

IMG2 = lagrange(IMG1, 512, 512, 5);

figure
imshowpair(IMG1, IMG2, 'montage');
title(['left: original', '  ', 'right: lagrange']);
