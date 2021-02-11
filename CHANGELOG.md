# Changelog

# 2.0.0

## Changes

All changes introduced by #6, @rm98

* Add support for RxSwift 6
* Fix SPM support
* Add support for RxSwift6
* Remove `ReactiveCall`
  * `ReactiveCompatible` now requires `AnyObject`, disallowing classes, and `Endpoints` and `Call`s are built around `struct`s
  
## Migration

* Refactor code that uses `ReactiveCall` to use a `Session`
```swift
// OLD
struct CustomCall: ReactiveCall { ... }

let client = CustomClient()
let call = CustomCall()

// 1
call.rx
    .response(with: client)
    ...

// 2
call.rx
    .values(with: client)
    ...

// NEW
struct CustomCall: Call { ... }

let client = CustomClient()
let session = Session(with: client)
let call = CustomCall()

// 1
session
    .start(call: call)
  
// 2
session
    .start(call: call)
    .map(\.value)
```

