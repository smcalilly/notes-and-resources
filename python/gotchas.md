you have an issue where you're deserializing a csv with `marshmallow`. sometimes a column with a float might be empty, but marshmallow validation fails despite telling it to allow this. 

the problem: python's csv is opening the file and casting to an empty string, instead of `None`, which would let your schema work. https://stackoverflow.com/questions/11379300/csv-reader-behavior-with-none-and-empty-string

h.c.:
>Ok, figured this out. Python's csv library loads null values as empty strings. Empty strings are (obviously) not None, hence allow_none does not permit them. You're on the right track with pre_load, but instead of coercing empty strings to zero, let's coerce them to None, and then use the allow_none flag for fields that can be empty:

### todo
- re-write this brain dump
