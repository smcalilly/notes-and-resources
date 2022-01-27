## useEffect
"anytime you want to have a side effect occur, whether it's when the component mounts, unmounts, when a variable changes, when the state changes, when your props change, when anything updates and you want to do something, this is what you want to use `useEffect` for"

## useMemo
https://www.youtube.com/watch?v=THL1OPn72vo&list=PLZlA0Gpn_vH8EtggFGERCwMY5u5hOjf-h&index=3
only use it when the function you call is incredibly slow, because the function itself has some performance overhead.

it's also helpful when you have referential equality issues (an object doesn't change but the reference in memory changes and therefore useEffect registers it as a change)

## useRef
https://www.youtube.com/watch?v=t2ypzz6gJm0&list=PLZlA0Gpn_vH8EtggFGERCwMY5u5hOjf-h&index=4
creates a reference that's similar to state, bc you can store a value and it's persists between renders. but it doesn't cause the component to re-render!

you can also use it to reference elements inside of your html. each element inside your document has a ref attribute. kinda similar to document.getElement...etc

ref.current

this component, when you click the focus button, it will call the `focus` function, which gets the `inputRef.current` (which is a reference to the input element and calls the js `focus` function. this puts the "focus" on the input element (aka makes the keyboard active in the input element so you can type into the input)
```jsx
import React, { useState, useRef } from 'react'

export default function App() {
  const [name, setName] = useState('')
  const inputRef = useRef()
  
  function focus() {
    inputRef.current.focus()
  }
  
  return (
    <>
      <input ref={inputRef} value={name} onChange={e => setName(e.target.value)} />
      <div>My name is {name}</div>
      <button onClick={focus}>Focus</button>
    </>
  )
}
```

this is the most common use case for refs. but because it's so easy, people tend to abuse it. instead of letting react manage state and all the changes, people tend to use ref to manage the onChange stuff.
