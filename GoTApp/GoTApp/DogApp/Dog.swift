import Foundation

struct Dog: Codable, Identifiable {
    let message: String
    let status: String
    
    var id: String { message }
    var url: URL { URL(string: message)! }
}
