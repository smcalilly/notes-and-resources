# not entirely my algorithm! mine was clunkier :P

def binary_search(list, item):
    mid = len(list) // 2

    if len(list) == 1:
        return list[mid] if list[mid] == item else None

    if list[mid] == item:
        return list[mid]

    if item > list[mid]:
        return binary_search(list[mid+1:], item)
    else:
        return binary_search(list[:mid], item)
    

my_list = [1, 3, 5, 7, 9]
s = binary_search(my_list, 8)
print(s)