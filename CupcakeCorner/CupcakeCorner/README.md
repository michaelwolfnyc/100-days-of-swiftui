#  README

Putting all the shared data in `class Order` and giving all the views access.  Passing that class around from view to view.  We’ve organized our code so that we have one Order object that gets shared between all our screens, which has the advantage that we can move back and forward between those screens without losing data. However, this approach comes with a cost: we’ve had to use the @Published property wrapper for the properties in the class, and as soon we did that we lost support for automatic Codable conformance.

First project where lots of screens.  Lots of NavigationView and NavigationLink.

