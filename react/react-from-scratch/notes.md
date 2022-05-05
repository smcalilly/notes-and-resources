concurrent  react from scratch
https://www.youtube.com/watch?v=fKlt5GFQnVc

- react fiber
- linked list traversal
- render then commit
- usestate hook
- work loop
- createroot()
- time slicing
- suspense

"last two are kind of marquee features of react, it's what you think of when you think of react"

react fiber rewrite from four years ago was powerful/fundamental for what react does

video is based on this https://pomb.us/build-your-own-react/

## jsx element
is just a plain old javascript object
- type (and key)
- props

```javascript
const element = {
	type: 'h1',
	props: {
		children: "hello w'rld"
	}
}
```

this is all that you need to represent html in javascript, which is essentially all that jsx is.


https://graphitemaster.github.io/fibers/

