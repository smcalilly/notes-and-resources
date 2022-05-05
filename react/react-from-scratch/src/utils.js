export function render(element, container) {
  console.log('element', element)
  if (typeof element.type === 'function') {} // TODO: dunno what's hear bc his screen cuts it off and can't find the source code!
  
  const dom =
    element.type === 'TEXT_ELEMENT'
      ? document.createTextNode('')
      : document.createElement(element.type)
    
    const isProperty = key => key !== 'children'
    
    Object.keys(element.props)
      .filter(isProperty)
      .forEach(name => {
        dom[name] = element.props[name]
      })
    
    element.props.children?.forEach(child => render(child, dom)) // not sure the second arg bc his screen cuts off the code
    container.appendChild(dom)
}

export function createTextElement(text) {
  return {
    type: 'TEXT_ELEMENT',
    props: {
      nodeValue: text,
      children: []
    }
  }
}

export function createElement(type, props, ...children) {
  return {
    type,
    props: {
      ...props,
      children: children.map(child => {
        return typeof child == 'object' ? child : createTextElement(child.text)
      })
    }
  }
}