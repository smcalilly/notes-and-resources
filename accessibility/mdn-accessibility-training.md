# accessibility
- sites should be accessible to keyboard, mouse, monitors, and touch screens, as well as other devices like screen readers and voice assistants
- applications should be understandable and usable by people regardless of auditory, visual, physical, or cognitive abilities
- by default, HTML is accessible, **if used correctly**

## html: a good basis for accessibility
use the correct html markup. semantic html!

for example, a `button` element has built-in keyboard accessibility. a user can navigate between buttons using the tab key, and activate their selection using return or enter.

### semantic html
start with semantic html!
- it's accessible
- better on mobile
- good for SEO
- easier to develop with

replace bad html code when encountered. sometimes you don't have control over this, so don't do an all or nothing approach. even a small improvement helps.

accessibility is literally built-in to semantic html. use it.

- littering the html with `br` tags isn't good because a screen reader will read that.
- heading tags are helpful because many screen readers can skip sections
- screen readers can also create a table of contents on a page based on headings. super helpful.

### clear language
language can also affect accessibility. use clear language, not too much jargon. avoid using special characters and language that aren't read well by screen readers.
- don't use dashes if possible. "5 to 7" is better than "5-7"
- expand abbreviations. instead of "Jan" write out "January"
- expand acronyms, at least once or twice. "hypertext markup language" > "HTML"

## page layouts
again, semantic html. use `div`s sparingly. try to find the best semantic html tag for what you need. header, nav, footer, aside, article, etc.

## ui controls
buttons, links, select, label, and form controls. by default, browsers allow these elements to be manipulated by the keyboard.

you get all this for free, simply by using the correct html elements!

## todo
pick backup here: https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML#meaningful_text_labels
