# intro to web accessibility video notes
[from this video](https://mawconsultingllc.com/webinars/webinar-intro-to-accessibility/)

## assistive technology

### OS settings

- users might be changing the OS display and interaction settings. based on what makes their device easiest to use
- adjust size, change color, make content spoken aloud
- like zoom -- allows a user to magnify the screen and user their finger to zoom different parts of the screen
- inverted color -- helps contrast. helps people with vision impairment and dyslexia 
- voice over -- aka a screen reader. helps people who are blind, low vision, or find audio output easier to use
  - output of a screen reader can be displayed in braille, using devices called "refreshbale braille displays". only interaction option for users who are both deaf and blind.

### software 
third party software that fills the gap with built-in software. provides screen readers and voice overs

## hardware
users might be using equipment apart from monitor, mouse, and keyboard. devices like a mouth stick, that a user uses to type. or a "switch" that helps a user operate their device.

## accessibility definition
ability for users with disabilities to access and contribute to technology content with their accomodations. unfortuately a lot of web technology isn't accessible. for example, content in text is accessible, but if the content is in an image of text, then a screen reader can't read it.

accessibility requires attention in design, code, and testing. an organization called WebAIM studied the home pages of websites and found that 98% of them had web accessibility errors.

## wcag
the web content accessibility guidelines -- standards by the W3C.
- perceivable
- operable
- understandable
- robust

html has a lot of this built-in, but many web pattern deviate from this. the `button` tag -- screen readers aren't seeing the button rendered on the screen, but instead they're reading the html code.

"for users of assistive technology, the markup *is* the UX" - ian pouncey.

aria properties (accessible rich internet applications) can help with this, but using native html elements coded to standard is first and best line of defence.

testers should train on assistive technology. each AT can have different outcomes, in the same way behavior can change across browsers.

research should include disabled participants. user feedback should include both participants with and without disabilities in all phases of research.

## accessibility is the law
it excludes people with disabilities. excluding people based on disabilities was made illegal in 1990 with the american's disabilities act. the law applies to digital spaces. we must make sure that everyone can participate.
