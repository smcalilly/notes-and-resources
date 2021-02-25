# react-leaflet
https://react-leaflet.js.org/docs/start-introduction

## core concepts
react leaflet provides bindings between react and leaflet. it doesn't replace leaflet, but leverages it to abstract leaflet layers as react components. as such, it can behave differently from how other react components work, notably:

### dom rendering
react **does not** render leaflet layers to the DOM. this rendering is done by leaflet itselft. react only renders a `<div>` when rendering the `MapContainer` components, the contents of UI layers components.

### component properties
the properties passed to the components are used to create the relevant leaflet instance when the component is rendered the first time. **these properties should be treated as immutable by default**.

during the first render, all these properties should be supported as they are by leaflet. **however, they will not be updated in the UI when they changed**, unless they explicitly documentated as being mutable.

mutable properties changes are compared by reference (unless stated otherwise) and applied calling the relevant method on the leaflet element instance.

### react context
react leaflet uses react's context api to make some leaflet elements instances available to children elements that need it.

each leaflet map instance has its own react contet, created by the `MapContainer` component. other components and hooks provided by react leaflet can only be used as descendants of a `MapContainer`.

## lifecyle process
1. the `MapContainer` renders a container `<div>` element for the map. if the placeholder prop is set, it will be rendered inside the container `<div>`.
2. the `MapContainer` instantiates a leaflet map for the `<div>` with the component properties, and creates the react context containing the map instance.
3. the `MapContainer` renders its children components
4. each child component instantiates the matching leaflet instance for the element using the component and properties and context, and adds it to the map.
5. when a child component is rendered again, changes to its supported mutable props are applied to the map
6. when a component is removed from the render tree, it removes its layer from the map as needed

## limitations
- leaflet makes direct calls to the DOM when it's loaded, therefore react leaflet is not compatible with server-side rendering
- the components exposed are abstractions for leaflet layers, not DOM elements. some of them have properties that can be updated directly by calling the setters exposed by leaflet. while others should be completely replaced, by setting a unique value on their key property so they are properly handled by react's algorithm.
