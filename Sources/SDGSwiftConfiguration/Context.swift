
import Foundation

/// A context provided by the configuration loader.
public protocol Context : Codable {

}

extension Context {

    /// Returns the context provided by the configuration loader.
    public static func accept() -> Self? {

        guard ProcessInfo.processInfo.arguments.count > 1 else {
            return nil
        }

        let json = ProcessInfo.processInfo.arguments[1]
        return (try? JSONDecoder().decode([Self].self, from: json.data(using: .utf8)!))?.first
    }
}
