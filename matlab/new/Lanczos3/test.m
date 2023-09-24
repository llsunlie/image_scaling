IMG1 = imread('../imgs/original/LenaRGB.bmp');

IMG2 = lanczos3(IMG1, 512, 512);

figure
imshowpair(IMG1, IMG2, 'montage');
title(['left: original', '  ', 'right: lanczos3']);
