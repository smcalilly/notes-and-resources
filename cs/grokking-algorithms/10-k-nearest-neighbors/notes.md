# k-nearest neighbors

## classifying fruit
you have your fruits on a graph. they're lumped together by classification. but what about a new fruit that falls in the middle and you aren't sure where to place?

1. you get a new fruit to classify
2. you look at its nearest three neighbors
3. more neighbors are oranges, so this is probably orange

## building a recommendation system
plot every user on a graph. they're plotted by similarity, so users with similar taste are plotted close together. suppose you want to recommend movies for priyanka. find the five users closest to her.

1. justin watches a movie
2. he likes it
3. recommend it priyanka, because he's near her

problem: you graphed users by similarity. how do you figure out how similar two users are?

### feature extraction
in the grapefruit example, you compared fruit based on how big they are and how red they are. size and color are *features* you're comparing. 

use these features to plot them on a graph, and use the pythagorean formula to find the distance between points on a graph.

what about when you have to calculate the distance in 5 dimensions? distance formula remains the same, it just involves a set of 5 numbers instead of 2 numbers.

- use normalization for users who have similar tastes but rate differently
- use weight for "influencers" ...

#### regression
predicts a response (like a user's rating), based on their neighbor's rating.

- cosine similarity, this is another formula to use rather than the distance formula. it doesn't measure the distance, but instead compares the angles of the two vectors. 

#### picking out good features
it's very important to pick the right features to compare against. that means:
- features that directly correlate to the movies you're trying to recommend
- features that don't have a bias (like if you tell them to only rate comedy movies, then it doesn't tell you whether they like action movies)

## introduction to machine learning

### ocr
optical character recognition

can you figure out what this number is? 7? KNN would:
- go through a lot of images of numbers and extract features of those numbers
- when you get a new image, extract features of that image and see what its KNN are.

feature extraction is a lot more complicated in OCR than the fruit example.

### building a spam filter
use the naive bayes classifier. first, train your naive bayes classifier on some data. for a basic one, you break the subject into words. for each word, see what the probablity is that it would show up in a spam email. naive bayes figures out the probability that something is likely to be spam. it has applications similar to the KNN.