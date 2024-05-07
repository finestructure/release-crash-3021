# Release crash

Minimal project demonstrating a runtime crash when running the project built in `release` mode. It does _not_ crash when run in `debug` mode.

This is a minimal reproducer of the issue initially discovered here: https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/3021

### How to trigger the crash

Run the server:

```
swift run -c release
```

In a terminal hit the endpoint:

```
curl -sL -w "%{http_code}" -o /dev/null http://localhost:8080/crash/1234567890
```

### Compiler versions tested

- 5.10 on macOS (via Xcode 15.3.0)

### A few observations

- The length of the `archive` parameter is relevant. It only crashes if it's >= 10 characters long.
- It's the `archive` parameter's length itself that's relevant, not the whole URL path `/crash/1234567890z`.
- A few simple modifications can avoid the crash:

Original:

```
let _ = ([archive].compacted() + req.parameters.getCatchall()).map { $0.lowercased() }  // ❌
```

Working variants:

```
let _ = ([archive].compactMap { $0 } + req.parameters.getCatchall()).map { $0.lowercased() }  // ✅
```

```
let _ = ([archive].compacted() + req.parameters.getCatchall())  // ✅
```