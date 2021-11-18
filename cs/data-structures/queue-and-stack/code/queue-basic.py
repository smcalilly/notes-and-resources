class MyQueue():
    def __init__(self):
        self._data = []
        self._start = 0

    def enqueue(self, x):
        self._data.append(x)
        return True
    
    def dequeue(self):
        if self.is_empty():
            return False
        self._start += 1
        return True

    def front(self):
        return self._data[self._start]

    def is_empty(self):
        return self._start >= len(self._data)
    
q = MyQueue()

q.enqueue(5)
q.enqueue(3)

if q.is_empty() == False:
    print(q.front())

q.dequeue()
if q.is_empty() == False:
    print(q.front())

q.dequeue()
if q.is_empty() == False:
    print(q.front())
