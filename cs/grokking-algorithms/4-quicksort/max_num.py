def max(list):
    print(f'list: {list}')
    # figure out a solution as a base case
    # you need two elements to compare to find the maximum
    if len(list) == 2:
        return list[0] if list[0] > list[1] else list[1]
    sub_max = max(list[1:])
    print(f'sub_max: {sub_max}')
    
    return list[0] if list[0] > sub_max else sub_max

m = max([4,99,33,85,1,0])
print(m)

# wtf!
# it's going through the list backwards
# list: [4, 99, 33, 85, 1, 0]
# list: [99, 33, 85, 1, 0]
# list: [33, 85, 1, 0]
# list: [85, 1, 0]
# list: [1, 0]
# sub_max: 1
# sub_max: 85
# sub_max: 85
# sub_max: 99
# 99