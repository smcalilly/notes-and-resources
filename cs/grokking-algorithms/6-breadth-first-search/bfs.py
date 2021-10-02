from collections import deque

def person_is_seller(person):
    """Determines if is person is a mango seller"""
    return person[-1] == 'm'

graph = {
    'you': ['alice', 'bob', 'claire'],
    'bob': ['anuj', 'peggy'],
    'alice': ['peggy'],
    'claire': ['thom', 'jonny'],
    'anuj': [],
    'peggy': [],
    'thom': [],
    'johnny': []
}


def search(name):
    search_queue = deque()
    search_queue += graph[name]
    searched = []
    while search_queue:
        # grab first person from the queue
        person = search_queue.popleft() 
        if not person in searched:
            if person_is_seller(person):
                print(f'{person} is a mango seller!')
                return True
            else:
                search_queue += graph[person]
    return False

search('you')