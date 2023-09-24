IMG1 = imread('../imgs/original/LenaRGB.bmp');

IMG2 = lanczos2(IMG1, 512, 512);

figure
imshowpair(IMG1, IMG2, 'montage');
title(['left: original', '  ', 'right: lanczos2']);
