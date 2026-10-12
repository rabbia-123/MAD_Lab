# OOP Lab Answers

Name: bibi rabbia
Roll no: 04072313042

**Q1. What can a subclass using extends use for free that a class using implements has to write itself?**
A subclass that uses extends gets all the code of the parent class for free. A class that uses implements gets only the names of the methods, so it has to write all the code itself.

**Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?**
I would use a mixin when a few classes need the same code, like Book and Dvd. I would use an abstract parent class when all the classes are the same kind of thing and share the same basic parts.

**Q3. Why must you override hashCode whenever you override ==?**
Sets and maps check hashCode first. If two equal objects have different hash codes, they are treated as different objects. So hashCode must match ==.

**Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?**
An extension just adds a new method to String without changing it. A subclass is not possible because String is a final class in Dart, so nobody can extend it.