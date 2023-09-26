function [res] = scaling_single_img(src_path, scaling_algorithm, args)

addpath '../algorithm/Bicubic'
addpath '../algorithm/Bilinear'
addpath '../algorithm/CubicBSpline'
addpath '../algorithm/Lagrange'
addpath '../algorithm/Lanczos2'
addpath '../algorithm/Lanczos3'
addpath '../algorithm/Nearest'
addpath '../algorithm/Newton'
addpath '../algorithm/Shannon'

% target_resolution_ratio
trr = args(1:2);

src = imread(src_path);

switch scaling_algorithm
    case "bicubic"
        res = bicubic(src, trr(1), trr(2));
    case "bilinear"
        res = bilinear(src, trr(1), trr(2));
    case "cubicBSpline"
        res = cubicBSpline(src, trr(1), trr(2));
    case "lagrange"
        res = lagrange(src, trr(1), trr(2), args(3));
    case "lanczos2"
        res = lanczos2(src, trr(1), trr(2));
    case "lanczos3"
        res = lanczos3(src, trr(1), trr(2));
    case "nearest"
        res = nearest(src, trr(1), trr(2));
    case "newton"
        res = newton(src, trr(1), trr(2), args(3));
    case "shannon"
        res = shannon(src, trr(1), trr(2), args(3));
    otherwise
        me = MException('[exception] scaling_algorithm: %s not exist!', scaling_algorithm);
        throw(me)
end