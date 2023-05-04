responsibilty-driven design, uses the words "roles" and "responsibilities" rather than "tasks". main point is to think about code in terms of behavior, rather than in terms of data or algorithms

abstract base class

layering
- encapsulation and abstraction help us by hiding details and protecting the consistency of our data, but we also need to pay attention to the interactions between our objects and functions. when one function etc uses another object, we say that the one "depends on" the other. forms a kind of network or graph

big ball of mud, dependencies out of control


layered architecture: presentation layer -> business logic -> database layer

### the dependency inversion principle
1. high-level modules should not depend on low-level modules. both should depend on abstractions
2. abstractions should not depend on details. instead details should depend on abstractions

high-level modules are the code that your org cares about. functions, classes, packages etc that deal with our real-world concepts

low-level are the things your org doesn't care about. filesystems, network sockets, smtp, http, etc. stuff stakeholders don't care about, they only care if the high-level concepts work correctly.

"Depends on" doesn't mean "imports" or "call", but rahter a general idea that one module knows about or needs another module.

so the first part of the DIP says that our business code shouldn't depend on techincal details, instead both should use abstractions

high-level stuff should be easy to change based on business needs. low-level are often harder to change. we don't want business logic changes to
