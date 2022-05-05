import './styles.css'
import { render, createTextElement, createElement } from './utils'

console.log('loaded')

const textEl = createTextElement('ello world')

// const element = {
// 	type: 'h1',
// 	props: {
// 		children: [textEl]
// 	}
// }
// 
// const element = createElement('h1', undefined, textEl)

React = { createElement }

const element = <h1>ello world</h1>;

const container = document.getElementById('root')

render(element, container)