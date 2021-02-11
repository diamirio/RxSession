# RxSession

RxSession is a `Swift Package` and a `CocoaPod` that integrates `Endpoints` with `RxSwift`.

It adds a `start(call:)` function to `Session` that return a `Single` that can be used instead of the completion handler of `Session.dataTask(for:completion:)`.

```swift
struct CustomCall: Call { ... }

let client = AnyClient(baseURL: ...)
let session = Session(with: client)

session.start(call: CustomCall())
   // rx-Chain
```
