# Common Python Data Structures


## Set
Set is like a math set. Every item is unique. Good for membership checks. Look ups have a time complexity of O(1). Python has some handy set methods.

https://docs.python.org/2/library/stdtypes.html#set

["are python sets immutable?"](https://stackoverflow.com/questions/14193438/are-python-sets-mutable/14193582):
> Sets are unordered.
> Set elements are unique. Duplicate elements are not allowed.
> A set itself may be modified, but the elements contained in the set must be of an immutable type.


### set example
```python
template = 'The quick brown fox jumped over the lazy dog.'
template_tokens = set(template.split())

text = 'The quick graying fox done went and jumped up over that lazy, sleepy dog.'
text_tokens = set(text.split())

# find the intersection of the sets
intersection = template_tokens & text_tokens
print(f'intersection: {intersection}')
print(f'intersection_length: {len(intersection)}')

# find the set distance
set_distance = len(intersection) / len(template_tokens)
print(f'set distance: {set_distance}')

# find the jaccard distance
jaccard_distance = len(intersection) / len(text_tokens | template_tokens) // can also do: len(text_tokens.union(template_tokens))
print(f'jaccard_distance: {jaccard_distance}')
```

## list vs tuple vs set
- a list is a dynamically sized array. you can store any type of object in one (#TODO: fact check). a list is mutable, which means you can add or remove an item.
- tuple is a collection (TODO: fact check -- "collection" came from one blog post but [this stackoverflow refutes that](https://stackoverflow.com/questions/13694034/is-a-python-list-guaranteed-to-have-its-elements-stay-in-the-order-they-are-inse#answer-13694111))  of elements much like a list, except it's immutable. it can't not be changed or replaced since it's immutable. they are faster and consume less memory (TODO: fact check).
- a set is like an array except every item in the set is unique. so if you try and put the same item in a set, it will only be there once.

read later:
https://www.digitalocean.com/community/tutorials/understanding-lists-in-python-3 and different pieces of that tutorial, like tuple and set

## set methods
```python
ground_truth = get_ground_truth()
print(f'ground_truth: {len(ground_truth)}')

extracted = get_extracted()
print(f'extracted: {len(extracted)}')

correct_extractions = ground_truth & extracted
print(f'correct_extractions: {len(correct_extractions)}')

recall = len(correct_extractions) / len(ground_truth)
print(f'recall: {recall}')

precision = len(correct_extractions) / len(extracted)
print(f'precision: {precision}')
```

```python
symmetric_difference = ground_truth ^ extracted
print(f'symmetric_difference: {symmetric_difference}')
```
