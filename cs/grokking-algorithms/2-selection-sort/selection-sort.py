def find_smallest(arr):
    smallest = arr[0]
    smallest_index = 0

    for index, element in enumerate(arr):
        if smallest > arr[index]:
            smallest = arr[index]
            smallest_index = index

    return smallest_index


def selection_sort(arr):
    new_arr = []

    for i in range(len(arr)):
        smallest = find_smallest(arr)
        new_arr.append(arr.pop(smallest))
    
    return new_arr

print(selection_sort([5, 3, 6, 2, 10]))