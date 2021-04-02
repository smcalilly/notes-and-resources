# intersection observer
[MDN docs have a lot of info](https://developer.mozilla.org/en-US/docs/Web/API/IntersectionObserverEntry/intersectionRatio)

intersection observer API allows you to configure a callback that executes when either:
- a target elemnt intersects the device's viewport or a specified element. that element is called the "root element" or `root` for the purposes of the intersection observer.
- the first time the observer is initially asked to watch a target element

the degree of intersection between the target element and its root is the **intersection ratio**. this is a representation of the percentage of the target element which is visible as a value between 0.0 and 1.0

## in the wild with react
here's a higher order component. i'm pretty sure i got the skeleton of this code from somebody else, but i've adapted for something i needed:
```jsx
import React from "react"

// Higher order component that tracks visibility,
// with callbacks passed in via props.
class TrackVisibility extends React.Component {
    ref = React.createRef()
  
    componentDidMount() {
      this.observer = new IntersectionObserver(
        ([entry]) => {
          if (entry.isIntersecting) {
            // if the element is visible on the 
            // page, return this function
            return this.props.isVisible()
          } else {
            return this.props.notVisible()
          }
        },
        {
          root: null,
          threshold: this.props.threshold,
        }
      )
  
      if (this.ref.current) {
        this.observer.observe(this.ref.current)
      }
    }
  
    componentWillUnmount() {
      this.observer.unobserve(this.ref.current)
    }
  
    render() {
      return <div ref={this.ref}>{this.props.children}</div>
    }
  }

export default TrackVisibility

```

i used it like this:
```jsx
import React, { useState } from "react"
import Footer from "./footer"
import Header from "./header"
import Popup from "./popup"
import TrackVisibility from './visibility'

const Layout = ({ children }) => {

  const [showPopup, setShowPopup] = useState(false)

  return (
    <>
      <Header />

      <TrackVisibility 
        isVisible={() => setShowPopup(false)} 
        notVisible={() => setShowPopup(true)}
        threshold={1.0}>
      </TrackVisibility>

      <main>{children}</main>
      <Footer locale={locale} showLanguageOption={showLanguageOption} />

      {showPopup ? <Popup /> : null}
    </>
  )
}

export default Layout
```

track visibility lives on the DOM. when the element is visible, a callback function called `isVisible` executes. in this case, it's `setShowPopup(false)`. once the element goes out of the viewport, the callback function `notVisible` executes.
