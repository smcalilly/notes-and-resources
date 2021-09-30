def sum_with_loop(arr):
    total = 0
    for x in arr:
        total += x
    return total

def sum(arr):
    if not arr:
        return 0
    return arr[0] + sum(arr[1:])

a = [2, 4, 6]
total = sum(a)
print(total)