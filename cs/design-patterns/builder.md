# Builder pattern
[notes from this guide](https://refactoring.guru/design-patterns/builder)

#### problem it solves
a complex object that requires many fields and nested objects and the steps it takes to populate that data.


## House

### problem
you have a `House` object. a basic house with four walls and a bathroom and bedroom, some windows and a door. 

but what about houses with variations? a big yard, a garden, some fancy statues, a swimming pool, a metal roof. you could extend the base `House` class to create subclasses to cover all the parameters, but you'll eventually end up with a ton of subclasses. any new parameter, like a screened porch, will require growing this hierarchy.

there's another approach that doesn't "involve breeding subclasses". you can create a giant constructor right in the base `House` class with all the possible pararameters that control the house object. but this creates another problem. a lot of the parameters will be unused and the constructor calls will be unwieldy.

### solution
the **Builder** pattern suggests that you extract the object construction code out of its own class and move it to seperate objects called builders.

the pattern organizes object construction into a set of steps (`build_walls`, `build_door`, etc). to create an object, you execute a series of those steps on a builder object.

#### Director
you can go further and create another classs called `Director`, who defines the order in which to execute the building steps, while the builder provides the implementation for those steps.

## notes
i don't think this pattern is what i need right now. [return to this later](https://refactoring.guru/design-patterns/builder#structure)
