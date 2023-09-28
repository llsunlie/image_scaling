import matplotlib.pyplot as plt


class ChartBarh:
    def __init__(self, data, yticks, yticklabels, xlabel, title):
        self.data = data
        self.data_len = len(data)
        self.data_min = min(data)
        self.data_max = max(data)
        self.data_range = self.data_max - self.data_min
        self.yticks = yticks
        self.yticklabels = yticklabels
        self.xlabel = xlabel
        self.xlim = [self.data_min - self.data_range * 0.1, self.data_max + self.data_range * 0.1]
        self.title = title


class MultiChartBarH:
    def __init__(self, chart_barh_list, row):
        self.chart_barh_list = chart_barh_list
        self.len = len(chart_barh_list)
        self.row = row
        self.col = (len(chart_barh_list) + row - 1) // row

    def plot(self):
        colors = plt.get_cmap('viridis')
        fig, ax = plt.subplots(self.row, self.col, figsize=(self.col * 4, self.row * 4))
        for i in range(self.row):
            for j in range(self.col):
                idx = i * self.col + j
                if idx >= self.len:
                    continue
                chart_barh = self.chart_barh_list[idx]
                ax[i, j].barh(range(chart_barh.data_len), chart_barh.data, color=colors(chart_barh.data / chart_barh.data_max))
                ax[i, j].set_yticks(range(chart_barh.data_len))
                ax[i, j].set_yticklabels(chart_barh.yticklabels)
                ax[i, j].set_title(chart_barh.title)
                ax[i, j].set_xlabel(chart_barh.xlabel)
                ax[i, j].set_xlim(chart_barh.xlim[0], chart_barh.xlim[1])
        plt.tight_layout()
        plt.show()