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

## labels
use good labels for things like buttons and links. don't use a generic "Click here" because that's not descriptive to a screen reader. it's especially bad if there are several "click here" buttons on a page -- a screen reader has no idea where "here" is. so use language that indicates where here is. 

this is their good example:
```html
<p>Whales are really awesome creatures. <a href="whales.html">Find out more about whales</a>.</p>
```

this is their bad example:
```html
<p>Whales are really awesome creatures. To find more out about whales, <a href="whales.html">click here</a>.</p>
```

### form labels
form's have the `label` tag that helps with this. using the `label` tag tells a screen reader what the form input is for. a good example:
```html
<div>
  <label for="name">Fill in your name:</label>
  <input type="text" id="name" name="name">
</div>
```

### aria-label
if an anchor tag doesn't have text in the link, use the `aria-label` attribute. but use this as a last resort, first try and use semantic html with good labels.

## tables
use `th` tags to help screen readers. the `caption` tag gives a summary.

## text alternatives
for `img`s, add alt text with the `alt` attribute. you can also add a `title`.

## links with onclick events
don't do it. don't add javascript to the link. don't override the default behavior. just use the `button` tag if you need something like that. semantic html!!!

## external links and non-html resources
if a link opens to a new tab or window, and there is no text telling a user that, then it might be confusing. here's a good example when targeting a new tab:
```html
<a target="_blank" href="https://www.wikipedia.org/">Wikipedia (opens in a new window)</a>
```

## skip links
help assitive technology navigate pages, when different sections are linked. read here for more details: https://developer.mozilla.org/en-US/docs/Learn/Accessibility/HTML#skip_links
