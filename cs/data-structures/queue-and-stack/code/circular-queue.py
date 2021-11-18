# this has a bug!
# this is a cleaner solution: https://dev.to/seanpgallivan/solution-design-circular-queue-mdp#idea
# it using a modulus to find the tail, nice! 
# oh wait, that guy took the answer from the lesson.

class MyCircularQueue:

    def __init__(self, k: int):
        self.size = k
        self.queue = [-1] * k
        self.head = -1
        self.tail = -1
        
    @property
    def size(self):
        return self._size
    
    @size.setter
    def size(self, k):
        if k > 1000:
            raise ValueError('Queue size cannot be larger than 1000.')
        self._size = k

    def enQueue(self, value: int) -> bool:
        # Inserts an element into the circular queue. Return true if the operation is successful.
        if value > 1000:
            raise ValueError('Item cannot be larger than 1000.')
        
        if self.isFull():
            return False
            # raise OverflowError('Cannot add to queue. It has too many items.')

        if self.isEmpty():
            self.head += 1
            self.tail += 1
            self.queue[self.tail] = value
            return True
        
        if self.tail == len(self.queue) - 1:
            self.tail = 0
        else:
            self.tail = self.tail + 1
        
        self.queue[self.tail] = value
        
        return True

    def deQueue(self) -> bool:
        # Deletes an element from the circular queue. Return true if the operation is successful.
        if self.isEmpty():
            return False
        
        _head = self.head
        self.queue[_head] = -1
        self.head = _head + 1
        return True

    def Front(self) -> int:
        # Gets the front item from the queue. If the queue is empty, return -1.
        if self.isEmpty():
            return -1
        
        return self.queue[self.head]

    def Rear(self) -> int:
        # Gets the last item from the queue. If the queue is empty, return -1.
        if self.isEmpty():
            return -1
        
        return self.queue[self.tail]    

    def isEmpty(self) -> bool:
        if self.head is -1 and self.tail is -1:
            return True
        return False

    def isFull(self) -> bool:
        if -1 in self.queue:
            return False
        return True


q = MyCircularQueue(5)
q.enQueue(1)
print(q.__dict__)
q.enQueue(3)
q.enQueue(8)
q.enQueue(11)
q.enQueue(12)
q.deQueue()
print(q.__dict__)
q.deQueue()
print(q.__dict__)
q.enQueue(11)
print(q.__dict__)
q.enQueue(22)
print(q.__dict__)
# Your MyCircularQueue object will be instantiated and called as such:
# obj = MyCircularQueue(k)
# param_1 = obj.enQueue(value)
# param_2 = obj.deQueue()
# param_3 = obj.Front()
# param_4 = obj.Rear()
# param_5 = obj.isEmpty()
# param_6 = obj.isFull()
