from utils.evaluate import Evaluate
from utils.chart_barh import ChartBarh, MultiChartBarH
from utils.img import MultiImg
from utils.log import log

def evaluate(SRC_PATH, ORIGINAL_IMG_PATH, TARGET_DIR, ALGORITHM_NAME_LIST, ALGORITHM_ARGS_MAP, SHOW_LOG):
    # 被缩放的图像路径
    IMG_NAME = SRC_PATH.split('/')[-1]
    IMG_SUFFIX = '.' + IMG_NAME.split('.')[-1]
    IMG_RESOLUTION_RATIO = IMG_NAME.split('_')[-1].split('.')[0]
    IMG_META_NAME = IMG_NAME.split('_')[0]
    SRC_DIR = '/'.join(SRC_PATH.split('/')[0:-1]) + '/' 
    if SHOW_LOG:
        log('IMG_NAME', IMG_NAME)
        log('IMG_SUFFIX', IMG_SUFFIX)
        log('IMG_RESOLUTION_RATIO', IMG_RESOLUTION_RATIO)
        log('IMG_META_NAME', IMG_META_NAME)
        log('SRC_DIR', SRC_DIR)

    # 缩放后的图像参考
    ORIGINAL_IMG_NAME = ORIGINAL_IMG_PATH.split('/')[-1]
    if SHOW_LOG:
        log('ORIGINAL_IMG_NAME', ORIGINAL_IMG_NAME)

    # 各种缩放算法处理后的图像路径
    TARGET_IMG_RESOLUTION_RATIO = ORIGINAL_IMG_NAME.split('_')[-1].split('.')[0]
    if SHOW_LOG:
        log('TARGET_IMG_RESOLUTION_RATIO', TARGET_IMG_RESOLUTION_RATIO)
    TARGET_PATH_LIST = []
    for algorithm_name in ALGORITHM_NAME_LIST:
        if algorithm_name in ALGORITHM_ARGS_MAP.keys():
            arg_list = ALGORITHM_ARGS_MAP[algorithm_name]
            arg_name = '_p' + '_'.join(str(i) for i in arg_list)
            target_path = TARGET_DIR + IMG_META_NAME + '_' + IMG_RESOLUTION_RATIO + '/' + algorithm_name + '/' + IMG_META_NAME + '_' + TARGET_IMG_RESOLUTION_RATIO + arg_name + IMG_SUFFIX    
        else:
            target_path = TARGET_DIR + IMG_META_NAME + '_' + IMG_RESOLUTION_RATIO + '/' + algorithm_name + '/' + IMG_META_NAME + '_' + TARGET_IMG_RESOLUTION_RATIO + IMG_SUFFIX
        TARGET_PATH_LIST.append(target_path)
    if SHOW_LOG:
        log('TARGET_PATH_LIST', TARGET_PATH_LIST)

    # 评估各种算法缩放后的图像
    eva_list = []
    for target_path in TARGET_PATH_LIST:
        eva = Evaluate(ORIGINAL_IMG_PATH, target_path)
        eva_list.append(eva)
    if SHOW_LOG:
        log('eva_list', eva_list)
    
    # 缩放后的图像拼图
    img_path_list = [ORIGINAL_IMG_PATH] + TARGET_PATH_LIST
    img_name_list = ['original'] + ALGORITHM_NAME_LIST
    MultiImg(
        suptitle = IMG_NAME + ' -> ' + ORIGINAL_IMG_NAME,
        img_path_list = img_path_list,
        img_name_list = img_name_list,
        row = 2,
        wspace = 0.02,
        hspace = -0.08
    ).plot()

    # 图像评价指标画图
    y_psnr_data = [eva.psnr for eva in eva_list]
    y_ssim_data = [eva.ssim for eva in eva_list]
    y_ms_ssim_data = [eva.ms_ssim for eva in eva_list]
    y_ws_psnr_data = [eva.ws_psnr for eva in eva_list]
    y_s_psnr_data = [eva.s_psnr for eva in eva_list]

    chart_barh_list = [
        ChartBarh(
            data = y_psnr_data,
            yticks = range(len(ALGORITHM_NAME_LIST)),
            yticklabels = ALGORITHM_NAME_LIST,
            xlabel = 'y_psnr_data',
            title = 'PSNR'
        ), 
        ChartBarh(
            data = y_ssim_data,
            yticks = range(len(ALGORITHM_NAME_LIST)),
            yticklabels = ALGORITHM_NAME_LIST,
            xlabel = 'y_ssim_data',
            title = 'SSIM'
        ), 
        ChartBarh(
            data = y_ms_ssim_data,
            yticks = range(len(ALGORITHM_NAME_LIST)),
            yticklabels = ALGORITHM_NAME_LIST,
            xlabel = 'y_ms_ssim_data',
            title = 'MS_SSIM'
        ), 
        ChartBarh(
            data = y_ws_psnr_data,
            yticks = range(len(ALGORITHM_NAME_LIST)),
            yticklabels = ALGORITHM_NAME_LIST,
            xlabel = 'y_ws_psnr_data',
            title = 'WS_PSNR'
        ), 
        ChartBarh(
            data = y_s_psnr_data,
            yticks = range(len(ALGORITHM_NAME_LIST)),
            yticklabels = ALGORITHM_NAME_LIST,
            xlabel = 'y_s_psnr_data',
            title = 'S_PSNR'
        )
    ]

    MultiChartBarH(
        suptitle = IMG_NAME + ' -> ' + ORIGINAL_IMG_NAME,
        chart_barh_list = chart_barh_list,
        row = 2
    ).plot()