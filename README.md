# ThreadSafe - Thread Safety in Swift

Concurrency in Swift is very tricky. Not only is the language changing regularly, possibly causing working to code to break, it has not brought forward useful features from Objective-C. One feature in particular in the `@synchronized` directive which ensures a block of code is thread safe. It is possible to use features like `NSLock` or `DispatchSemaphore` but these are not as simple to use as the directive available in Objective-C.

This sample project implements functionality like `@synchronized` for Swift. It uses `DispatchSemaphore` to ensure only one instance is executed at a time. It uses a global variable for the semaphore which may not be ideal for a high performant application. For simple cases this solution may be sufficient. Feedback in the form of new Issues or Pull Requests are appreciated.

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
