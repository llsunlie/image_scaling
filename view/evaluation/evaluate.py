import cv2
import numpy as np


def psnr(img1, img2):
    mse = np.mean((img1 - img2) ** 2)
    if mse == 0:
        return 100
    PIXEL_MAX = 255.0
    return 20 * np.log10(PIXEL_MAX / np.sqrt(mse))


def ssim(img1, img2):
    C1 = (0.01 * 255) ** 2
    C2 = (0.03 * 255) ** 2

    img1 = img1.astype(np.float64)
    img2 = img2.astype(np.float64)
    kernel = cv2.getGaussianKernel(11, 1.5)
    window = np.outer(kernel, kernel.transpose())

    mu1 = cv2.filter2D(img1, -1, window)
    mu2 = cv2.filter2D(img2, -1, window)
    mu1_sq = mu1 ** 2
    mu2_sq = mu2 ** 2
    mu1_mu2 = mu1 * mu2

    sigma1_sq = cv2.filter2D(img1 ** 2, -1, window) - mu1_sq
    sigma2_sq = cv2.filter2D(img2 ** 2, -1, window) - mu2_sq
    sigma12 = cv2.filter2D(img1 * img2, -1, window) - mu1_mu2

    ssim_map = ((2 * mu1_mu2 + C1) * (2 * sigma12 + C2)) / \
        ((mu1_sq + mu2_sq + C1) * (sigma1_sq + sigma2_sq + C2))
    return ssim_map.mean()


def ms_ssim(img1, img2):
    weights = [0.0448, 0.2856, 0.3001, 0.2363, 0.1333]
    mssim = []

    for _ in range(len(weights)):
        mssim.append(ssim(img1, img2))

        if img1.shape[0] < 2 or img1.shape[1] < 2:
            break

        img1 = cv2.pyrDown(img1)
        img2 = cv2.pyrDown(img2)

    return np.prod([m ** w for m, w in zip(mssim, weights)])


def ws_psnr(img1, img2):
    weights = np.ones_like(img1, dtype=np.float32) / \
        (img1.shape[0] * img1.shape[1])
    mse = np.mean(weights * ((img1 - img2) ** 2))
    PIXEL_MAX = 255.0
    return 10 * np.log10((PIXEL_MAX ** 2) / mse)


def s_psnr(img1, img2):
    weights = np.ones_like(img1, dtype=np.float32) / \
        (img1.shape[0] * img1.shape[1])
    mse = np.mean(weights * ((img1 - img2) ** 2))
    PIXEL_MAX = 255.0
    return 10 * np.log10((PIXEL_MAX ** 2) / mse)


def psnr_color(img1, img2):
    return np.mean([psnr(img1[:, :, i], img2[:, :, i]) for i in range(img1.shape[2])])


def ssim_color(img1, img2):
    return np.mean([ssim(img1[:, :, i], img2[:, :, i]) for i in range(img1.shape[2])])


def ms_ssim_color(img1, img2):
    return np.mean([ms_ssim(img1[:, :, i], img2[:, :, i]) for i in range(img1.shape[2])])


def ws_psnr_color(img1, img2):
    return np.mean([ws_psnr(img1[:, :, i], img2[:, :, i]) for i in range(img1.shape[2])])


def s_psnr_color(img1, img2):
    return np.mean([s_psnr(img1[:, :, i], img2[:, :, i]) for i in range(img1.shape[2])])


class Evaluate:
    def __init__(self, source_path, target_path):
        self.source_path = source_path
        self.target_path = target_path
        src_img = cv2.imread(source_path)
        tgt_img = cv2.imread(target_path)
        self.psnr = psnr_color(src_img, tgt_img)
        self.ssim = ssim_color(src_img, tgt_img)
        self.ms_ssim = ms_ssim_color(src_img, tgt_img)
        self.ws_psnr = ws_psnr_color(src_img, tgt_img)
        self.s_psnr = s_psnr_color(src_img, tgt_img)

    def __str__(self):
        return 'Evaluate(\
                    source_path = %s, \
                    target_path = %s, \
                    psnr = %f, \
                    ssim = %f, \
                    ms_ssim = %f, \
                    ws_psnr = %f, \
                    s_psnr = %f \
                )' % (
                    self.source_path, 
                    self.target_path, 
                    self.psnr, 
                    self.ssim, 
                    self.ms_ssim, 
                    self.ws_psnr,
                    self.s_psnr
                )

    def __repr__(self):
        return 'Evaluate(\
                    source_path = %s, \
                    target_path = %s, \
                    psnr = %f, \
                    ssim = %f, \
                    ms_ssim = %f, \
                    ws_psnr = %f, \
                    s_psnr = %f \
                )' % (
                    self.source_path, 
                    self.target_path, 
                    self.psnr, 
                    self.ssim, 
                    self.ms_ssim, 
                    self.ws_psnr,
                    self.s_psnr
                )