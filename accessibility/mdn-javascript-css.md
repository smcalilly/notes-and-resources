# javascript and css
https://developer.mozilla.org/en-US/docs/Learn/Accessibility/CSS_and_JavaScript

css and js don't have the same accessibility features as semantic html. they can be bad for accessibility if used improperly

## css
use good design in unison with semantic html. headings should look like heading, etc

> - Select sensible font sizes, line heights, letter spacing, etc. to make your text logical, legible, and comfortable to read.
> - Make sure your headings stand out from your body text, typically big and bold like the default styling. Your lists should look like lists.
> - Your text color should contrast well with your background color.

style in simple ways. don't override defaults for `em` and `strong` tags, etc. use the `abbr` tag for abbreviations (that's semantic html!)

there is a default for link colors based on the state of the link (clicked on/not). if you change that, be intentional and consistent. don't change the pointer cursor.

don't deviate from expected visual feedback for forms, like focus/hover states.

### color and contrast
make sure that text has good contrast with the background. [use this tool for checking contrast](https://webaim.org/resources/contrastchecker/)

### tabbing
sometimes, content is tabbed. absolute positioning help screen readers in this case. 

don't use `visibility:hidden` or `display:none` because that will hide the element from screen readers (unless of course you want to hide it)

## javascript
JS can break accessibility, depending on how it's used.

one way to improve improve accessibility for non-semantic JavaScript-powered widgets is to use WAI-ARIA to provide extra semantics for screen reader users. The next article will also cover this in detail.

webGL / canvas tag isn't accessible.

too much javascript tends to be bad for accessibility. think about whether you need it, or whether some plain text/html does the job.

### unobtrusive javascript
keep js unobtrusive when creating content. it should be used where ever possible to enhance functionality, but the UI shouldn't be built with it. basic functions should work ideally without it. use built-in browser functionality whenever possible.

good examples include:
- providing client-side validation. if it's unavaible, and the form is validated on the server, then it might take longer. but it's still accessible.
- "Providing custom controls for HTML5 <video>s that are accessible to keyboard-only users, along with a direct link to the video that can be used to access it if JavaScript is not available (the default <video> browser controls aren't keyboard accessible in most browsers)."


### other js issues

mouse specific events -- double up event handlers so that screen readers can use them, since AT don't "click" -- `focus` and `blur` would provide accessibility for keyboard users

