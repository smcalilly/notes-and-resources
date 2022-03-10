# Fuzzy Matching with csvmatch
- [csvmatch repo](https://github.com/maxharlow/csvmatch)
- [slides for the presentation](bit.ly/3hwwjVl)

Matching up two sets of things that aren’t quite the same but refer to the same thing

Like the names of people or companies
Boris johnson
4 diff names on his wikipedia

Showed some examples for using it in reporting at financial times

Start by doing exact match
Which people are on both forbes and bloomber billionaires list?

Normalizing

Fuzzy matching with “edit distances”
Levenshtein distance
example: Max Harlow vs Max Harkow
String distance

False negatives and false positives
Aka type1 vs type2 errors
Aka accuracy vs recall

Fuzzy matching with phonetics

Metaphone

Fuzzy matching with machine learning

bilenko…it’s using dedupe!


csvmatch:
use with medium sized data only
Every row needs to be matched against every other row… time = rows1 * rows2
Both files need to be in your computer’s memory, if their combined size exceeds your computer’s memory it won’t work

You can also do this in python code:
- fuzzy_pandas
- dedupe!
- fuzzymatcher


R:
- fuzzyjoin
