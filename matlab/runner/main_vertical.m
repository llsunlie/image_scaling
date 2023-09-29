addpath '../algorithm/Bicubic'
addpath '../algorithm/Bilinear'
addpath '../algorithm/CubicBSpline'
addpath '../algorithm/Lagrange'
addpath '../algorithm/Lanczos2'
addpath '../algorithm/Lanczos3'
addpath '../algorithm/Nearest'
addpath '../algorithm/Newton'
addpath '../algorithm/Shannon'

% 目标路径
TARGET_DIR = '../../data/target/';

% 构造 IMG 路径与文件名
IMG_META_NAME = 'img3';
IMG_RESOLUTION_RATIO_LIST = [
    [160, 90];
    [640, 360];
    [1280, 720];
    [1920, 1080]
];
IMG_SUFFIX = '.png';
SRC_DIR = '../../data/src/';
src_path_list = [];
for idx = 1 : length(IMG_RESOLUTION_RATIO_LIST)
    irr = IMG_RESOLUTION_RATIO_LIST(idx, :);
    img_name = [IMG_META_NAME, '_', num2str(irr(1)), 'x', num2str(irr(2)), IMG_SUFFIX];
    src_path = [SRC_DIR, img_name];
    src_path_list = [src_path_list; string(src_path)]; %#ok<AGROW>
end

% 初始化需要跑的缩放算法
FUNCTIONS = [
    "bicubic";
    "bilinear";
    "cubicBSpline";
    "lagrange";
    "lanczos2";
    "lanczos3";
    "nearest";
    "newton";
    "shannon"
];

% 缩放算法的参数
ARGS = [
    [160, 90];
    [640, 360];
    [1280, 720];
    [1920, 1080]
];
ARGS_FOR_LANGRANGE = [
    [160, 90, 3];
    [640, 360, 3];
    [1280, 720, 3];
    [1920, 1080, 3]
];
ARGS_FOR_NEWTON = [
    [160, 90, 3];
    [640, 360, 3];
    [1280, 720, 3];
    [1920, 1080, 3]
];
ARGS_FOR_SHANNON = [
    [160, 90, 3];
    [640, 360, 3];
    [1280, 720, 3];
    [1920, 1080, 3]
];

% 对每一个 IMG 套用缩放算法
for idx = 1 : length(src_path_list)
    disp('<= nxt img =>');
    src_path = src_path_list(idx);
    disp(['[process]', char(src_path)]);
    src_name = strsplit(src_path, '/');
    src_name = strsplit(src_name(end), '.');
    src_name = src_name(1);
    for i = 1 : length(FUNCTIONS)
        func = FUNCTIONS(i);

        % 创建文件夹
        target_new_dir = [
            TARGET_DIR, ...
            char(src_name), '/', ...
            char(func), '/'
        ];
        if exist(target_new_dir, 'dir') == 0
            mkdir(target_new_dir);
        end

        % 初始化参数
        switch func
            case "lagrange"
                args = ARGS_FOR_LANGRANGE;
            case "newton"
                args = ARGS_FOR_NEWTON;
            case "shannon"
                args = ARGS_FOR_SHANNON;
            otherwise
                args = ARGS;
        end
        
        for j = 1 : length(args)
            params = args(j, :);
            switch char(func)
                case {'lagrange', 'newton', 'shannon'}
                    target_name = [IMG_META_NAME, '_', num2str(params(1)), 'x', num2str(params(2)), '_p', num2str(params(3)), IMG_SUFFIX];
                otherwise
                    target_name = [IMG_META_NAME, '_', num2str(params(1)), 'x', num2str(params(2)), IMG_SUFFIX];
            end
            target_path = [target_new_dir, target_name];
            img = scaling_single_img(src_path, func, params);
            imwrite(img, target_path);
            disp(['[success]', target_path]);
        end
    end
end
