# ThreadSafe - Thread Safety in Swift

Concurrency in Swift is very tricky. Not only is the language changing regularly, possibly causing working code to break, it has not brought forward useful features from Objective-C which simplified thread safety. One feature in particular in the `@synchronized` directive which ensures a block of code is thread safe. It is possible to use features like `NSLock` or `DispatchSemaphore` but these are not as simple to use as the directive available in Objective-C.

This sample project implements functionality like `@synchronized` for Swift. It uses `DispatchSemaphore` to ensure only one instance is executed at a time. It uses a global variable for the semaphore which may not be ideal for a high performant application. For simple cases this solution may be sufficient. Feedback in the form of new Issues or Pull Requests are appreciated.

## Why?

Managing code which is running concurrently across different threads or queues is dangerous because values may not be in sync and implementing a concurrency solution risks deadlocking which is hard to track down and fix. That is what made the `@synchronized` directive in Objective-C so helpful. It made the implementation simple which reduced the risk of values getting out of sync or causing a deadlock.

With optionals and initialization being such an important focus in Swift there are often constructs in place which will require managing a thread safe initialization sequence. It is tempting to use a `lazy` property, assuming the block is only run once and is thread safe, but it is not. The documentation on [Properties] notes
the following:

> If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property has not yet been initialized, there is no guarantee that the property will be initialized only once.

Since it is not possible to rely on atomic properties it is necessary to ensure that critical properties are managed in a thread safe way. And a reuseable solution allows for relying on a tested solution which is known to work instead of carefully implementing a unique implementation each time it is needed.

## Usage

Run a synchronized block which is non-escaping with the code below.

```swift
public func work() {
    synchronized {
        // do work here
    }
}
```

When your closure returns a value you can do so with a variation of the same function.

```swift
private func work() {
    synchronized { () -> String in
        // return a value after working
    }
}
```

## Testing

A series of unit tests are included which attempt to break the implementation. Run these unit tests yourself with the version of Swift you are using to ensure that the synchronized functions work as intended.

## License

MIT

---

Brennan Stehling (c) 2017

[Properties]: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html