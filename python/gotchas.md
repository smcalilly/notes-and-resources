you have an issue where you're deserializing a csv with `marshmallow`. sometimes a column with a float might be empty, but marshmallow validation fails despite telling it to allow this. 

the problem: python's csv is opening the file and casting to an empty string, instead of `None`, which would let your schema work. https://stackoverflow.com/questions/11379300/csv-reader-behavior-with-none-and-empty-string

### todo
- re-write this brain dump
