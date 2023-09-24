IMG1 = imread('../imgs/original/LenaRGB.bmp');

IMG2 = newton(IMG1, 512, 512, 2);

figure
imshowpair(IMG1, IMG2, 'montage');
title(['left: original', '  ', 'right: newton']);
