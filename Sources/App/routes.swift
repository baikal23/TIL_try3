import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    // Register a new route at /api/acronyms that accepts a POST request and returns
    // Future<Acronym>. It returns the acronym once it’s saved.
    router.post("api", "acronyms") { req -> Future<Acronym> in
        // Decode request's JSON into Acronym model using Codable
        // this returns a Future<Acronym> so it needs a flatMap(to:)
        return try req.content.decode(Acronym.self)
            .flatMap(to: Acronym.self) { acronym in
                // save the model using Fluent
                return acronym.save(on: req)
        }
    }
}

