def quicksort(array):
    if len(array) < 2:
        return array # base case: arrays with 0 or 1 element are already "sorted"
    else:
        # recursive case
        pivot = array[0]

        # subarray of all the elements less than the pivot
        less = [i for i in array[1:] if i <= pivot]

        # subarray of all the elements greater than the pivot
        greater = [i for i in array[1:] if i >= pivot]

        return quicksort(less) + [pivot] + quicksort(greater)

l = [4,99,33,85,1,0]
sorted = quicksort(l)
print(sorted)