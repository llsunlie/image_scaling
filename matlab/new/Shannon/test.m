IMG1 = imread('../imgs/original/LenaRGB.bmp');

IMG2 = shannon(IMG1, 512, 512, 5);

figure
imshowpair(IMG1, IMG2, 'montage');
title(['left: original', '  ', 'right: shannon']);
