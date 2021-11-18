# queue and stack

two different processing orders:
- first in, first out == `queue`
- last in, first out == `stack`

## queue: first-in-first-out data structure
in a FIFO data structure, the first element added to the queue will be processed first.
- enqueue puts an item in the back of the queue
- dequeue removes the first item from the queue


### implement a queue
trying to refactor the java example to python
```python
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
```

run: `python3 cs/data-structures/code/queue-basic.py`

this isn't the most efficient solution, though. it wastes storage.

### circular queue
is more efficient. we can use a fixed-size array and two pointers to indicate the starting position and the ending position. the goal is to reuse the wasted storage.

attempt at implementing it: `python3 cs/data-structures/code/circular-queue.py`

got caught up over -1 and trying to implement it as `None`.

the java implementation:
```java
class MyCircularQueue {
    
    private int[] data;
    private int head;
    private int tail;
    private int size;

    /** Initialize your data structure here. Set the size of the queue to be k. */
    public MyCircularQueue(int k) {
        data = new int[k];
        head = -1;
        tail = -1;
        size = k;
    }
    
    /** Insert an element into the circular queue. Return true if the operation is successful. */
    public boolean enQueue(int value) {
        if (isFull() == true) {
            return false;
        }
        if (isEmpty() == true) {
            head = 0;
        }
        tail = (tail + 1) % size;
        data[tail] = value;
        return true;
    }
    
    /** Delete an element from the circular queue. Return true if the operation is successful. */
    public boolean deQueue() {
        if (isEmpty() == true) {
            return false;
        }
        if (head == tail) {
            head = -1;
            tail = -1;
            return true;
        }
        head = (head + 1) % size;
        return true;
    }
    
    /** Get the front item from the queue. */
    public int Front() {
        if (isEmpty() == true) {
            return -1;
        }
        return data[head];
    }
    
    /** Get the last item from the queue. */
    public int Rear() {
        if (isEmpty() == true) {
            return -1;
        }
        return data[tail];
    }
    
    /** Checks whether the circular queue is empty or not. */
    public boolean isEmpty() {
        return head == -1;
    }
    
    /** Checks whether the circular queue is full or not. */
    public boolean isFull() {
        return ((tail + 1) % size) == head;
    }
}

/**
 * Your MyCircularQueue object will be instantiated and called as such:
 * MyCircularQueue obj = new MyCircularQueue(k);
 * boolean param_1 = obj.enQueue(value);
 * boolean param_2 = obj.deQueue();
 * int param_3 = obj.Front();
 * int param_4 = obj.Rear();
 * boolean param_5 = obj.isEmpty();
 * boolean param_6 = obj.isFull();
 */
 ```

### recap
most languages already have a queue so there is no need to reinvent the wheel.

whenever you want to process the elements in order, using a queue might be a good choice.


### moving average
Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window.

Implement the MovingAverage class:

    MovingAverage(int size) Initializes the object with the size of the window size.
    double next(int val) Returns the moving average of the last size values of the stream.
