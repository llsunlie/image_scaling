IMG1 = imread('../imgs/original/a.png');

IMG2 = nearest(IMG1, 200, 200);

figure
imshowpair(IMG1, IMG2, 'montage');
title(['left: original', '  ', 'right: nearest']);
