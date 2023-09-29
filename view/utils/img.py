import matplotlib.pyplot as plt
from PIL import Image


class MultiImg:
    def __init__(self, suptitle, img_path_list, img_name_list, row, wspace, hspace):
        self.suptitle = suptitle
        self.img_path_list = img_path_list
        self.img_name_list = img_name_list
        self.img_count = len(img_path_list)
        self.row = row
        self.col = (self.img_count + row - 1) // row
        self.wspace = wspace
        self.hspace = hspace

    def plot(self):
        fig, ax = plt.subplots(self.row, self.col)
        fig.suptitle(self.suptitle)
        for i in range(self.row):
            for j in range(self.col):
                idx = i * self.col + j
                if idx >= self.img_count:
                    continue
                img = Image.open(self.img_path_list[idx])
                ax[i, j].imshow(img)
                ax[i, j].axis('off')
                ax[i, j].set_title(self.img_name_list[idx], y = 0.01)
        plt.subplots_adjust(wspace = self.wspace, hspace = self.hspace)
        plt.show()