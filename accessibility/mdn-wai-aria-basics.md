# WAI-ARIA
a lot of JS isn't accessible and WAI-ARIA spec helps to overcome that.

three main features in the spec:
1. roles
  - define what an element is or does. aka "landmark roles", like `role="search"` or `role="banner"`
2. properties
  - define properties of elements, which can be used to give them extra meaning or semantics.
  -  "As an example, aria-required="true" specifies that a form input needs to be filled in order to be valid, whereas aria-labelledby="label" allows you to put an ID on an element, then reference it as being the label for anything else on the page, including multiple elements, which is not possible using <label for="input">. "
3. states
  - "Special properties that define the current conditions of elements, such as aria-disabled="true", which specifies to a screenreader that a form input is currently disabled."
  
  
WAI-ARIA attributes don't affect anything about the webpage, like presentation or functionality. only share info to the web accessibility api.

## where is wai-aria supported?
hard to say, especially since all the browsers are different. go here to read more details: https://developer.mozilla.org/en-US/docs/Learn/Accessibility/WAI-ARIA_basics#where_is_wai-aria_supported

## when yo use wai-aria labels?
1. signposts/landmarks
2. dynamic content updates -- screen readers have a hard time keeping up with live site updates.
3. enhancing keyboard accessibility -- when semantic html isn't available and there's a lot of JS doing stuff
4. accessibility of non-semantic controls -- div soup and you need some way to signal what's what

here are some good examples of each of those: https://developer.mozilla.org/en-US/docs/Learn/Accessibility/WAI-ARIA_basics#practical_wai-aria_implementations
