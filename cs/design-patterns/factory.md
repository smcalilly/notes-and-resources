# factory method
notes from here: https://refactoring.guru/design-patterns/factory-method

factory method is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.

## the problem
your logistics business does a good job managing truck fleets but you have an opportunity to start managing boat shipping fleets. you need to update your software to do this. so you modify the software with a ton of if/else conditionals, or you use the factory pattern.

## solution
factory method pattern suggests that you replace direct object construction calls with calls to a special factory method. 
