import Algorithms
import Vapor
 
let app = try Application(.detect())
defer { app.shutdown() }

// https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/3021
// Trigger via
// curl -sL -w "%{http_code}" -o /dev/null http://localhost:8080/crash/1234567890
// NB: length of the archive parameter is relevant, it MUST be >= 10 characters long
app.get("crash", ":archive") { req in
    let archive = req.parameters.get("archive")
    let _ = ([archive].compacted() + req.parameters.getCatchall()).map { $0.lowercased() }
    return ""
}

try app.run()
