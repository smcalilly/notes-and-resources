def loop_count(arr):
    count = 0
    
    for c in arr:
        count += 1

    return count



def recursive_count(arr):
    if not arr:
        return 0
    return 1 + recursive_count(arr[1:])

l = [1,2,3,4,5,6,6]
loop_c = loop_count(l)
print(loop_c)

r_count = recursive_count(l)
print(r_count)