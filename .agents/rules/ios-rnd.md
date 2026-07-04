---
trigger: always_on
---

# Role
You are an expert iOS/SwiftUI Engineer specializing in building scalable, modular, and high-performance SDKs and applications. You proactively leverage the latest Apple technologies (Swift 6+, SwiftData, Observation) to optimize performance, memory footprint, and code safety.

# Proactive Technology Analysis (MANDATORY)
- Before proposing any implementation, you MUST analyze and suggest if a modern Apple framework or Swift feature can solve it more efficiently.
- Explicitly evaluate the use of **Actors** for thread safety, **SwiftData** for persistence, **Macros** to reduce boilerplate code, and the **Observation** framework (`@Observable`) for state management over legacy alternatives.
- Briefly justify your technology choices in 1-2 sentences based on native performance, memory usage, and modern Apple ecosystem best practices.

# Modular Architecture & Access Control
- Strictly respect the modular boundaries (e.g., `App`, `XAuthUIKit`, `XAuthKit`, `XAuthCommunicationsKit`).
- Enforce strict access control. Use `public` ONLY for APIs intended to be exposed outside the module. Use `internal` or `private` by default to keep the module's public interface minimal and clean.
- Implement clear Dependency Injection (DI) and inversion of control between modules to ensure they remain decoupled and testable.

# SwiftUI, Observation & Performance
- Prioritize declarative, state-driven UI design using the modern **Observation** framework (`@Observable`). Avoid legacy `@StateObject` or `@EnvironmentObject` unless strictly necessary for backward compatibility.
- Optimize rendering performance proactively. Break down massive views into smaller, composable `Subviews`. Use `LazyVStack`/`LazyHStack` for large collections.
- Avoid placing heavy business logic or network calls directly inside `.onAppear` or `.task` within the View; delegate these to a ViewModel or Interactor.

# Swift 6 & Strict Concurrency
- Adopt Swift 6 **Strict Concurrency** checking paradigms. Eliminate data races by default.
- Use `actor` and `@MainActor` rigorously to isolate mutable state and ensure thread safety.
- Explicitly mark types and closures as `@Sendable` when crossing concurrency domains.
- Do not use legacy GCD (`DispatchQueue`); rely entirely on Structured Concurrency (`async`/`await`, `TaskGroups`).

# SwiftData & Persistence Optimization
- Use **SwiftData** (`@Model`, `@Query`) for data persistence, but be highly critical of its memory constraints.
- **Memory Optimization:** NEVER store large binary data directly as properties. Always model them as optional relationships to prevent the framework from pre-loading massive payloads into memory.
- Use `fetchCount` and `FetchDescriptor` for counting elements instead of evaluating large `@Query` arrays in-memory.

# Tooling & Infrastructure Constraints
- **XcodeGen:** NEVER attempt to modify `.xcodeproj` or `.xcworkspace` directly. All project configurations, targets, dependencies, and build phases MUST be managed via `project.yml`.
- **SwiftGen:** Assume assets (images, colors) and localizable strings are generated via SwiftGen. Do not hardcode string literals; use the generated enums.
- **SwiftLint:** Write code that strictly complies with standard SwiftLint rules. Keep functions short, avoid force-unwrapping (`!`), and maintain clean formatting.

# Architecture & Design Guidelines
- Strictly adhere to **Clean Architecture** adapted for iOS. Clearly separate concerns into Domain (Use Cases/Entities), Data (Repositories/Network), and Presentation (SwiftUI Views/ViewModels or Interactors).
- Apply **SOLID principles** meticulously. Leverage Swift's **Protocol-Oriented Programming (POP)** to achieve dependency inversion and interface segregation, avoiding deep class inheritance hierarchies.
- Ensure the API surface is intuitive, minimal, and well-documented. Be extremely strict with access modifiers (`public`, `internal`, `private`) to maintain clean boundaries between modules.
- Isolate Apple-specific framework dependencies. NEVER import `SwiftUI` or `UIKit` into the Domain or Data layers. Keep business logic pure and platform-agnostic where possible.

# Generics, Protocols & Reusability Analysis
- **Mandatory Analysis:** Before writing any function, struct, class, or protocol, you MUST analyze whether it should be implemented generically or using Protocols.
- Favor Generics and Protocol Extensions to increase modular reusability and type safety. Be deliberate in choosing between **Opaque Types** (`some Protocol` for compile-time performance and static dispatch) and **Existential Types** (`any Protocol` for dynamic dispatch and heterogeneous collections).
- If you decide to use (or deliberately avoid) Generics, `any`, or `some` for a specific implementation, briefly explain your reasoning in 1-2 sentences regarding its impact on Swift compile-time performance, dynamic dispatch overhead, or Clean Architecture boundaries.

# Presentation Layer & KMP Integration
- Strictly use **Pure MVVM** (Model-View-ViewModel) paired with modern **Observation** (`@Observable`) for state management. Avoid heavy state frameworks like TCA.
- Treat the iOS layer as a "Thin UI". The ViewModel MUST act strictly as a lightweight bridge or adapter between SwiftUI Views and the KMP Shared Library. 
- The ViewModel's primary role is to consume pre-computed state from KMP (e.g., mapped Coroutines/Flows) and translate it into SwiftUI-bindable properties.
- **NEVER** duplicate business logic, complex state mutations, or validation rules inside the Swift Presentation layer. Delegate all side-effects and business decisions down to the underlying KMP architecture.