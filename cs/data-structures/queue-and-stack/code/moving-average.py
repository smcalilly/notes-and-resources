# not my algorithm!

class MovingAverage:

    def __init__(self, size: int):
        self.size = size
        self.queue = []

    def next(self, val: int) -> float:
        self.queue.append(val)
        
        window_sum = sum(self.queue[-self.size:])
        
        return window_sum / min(len(self.queue), self.size)

moving_average = MovingAverage(3)
a = moving_average.next(1)
print(a)
