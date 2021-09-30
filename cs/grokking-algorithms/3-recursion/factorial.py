def factorial(x):
    if x == 1:
        return x
    return x * factorial(x - 1)

f = factorial(3)
print(f)