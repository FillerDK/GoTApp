import Foundation

class NetworkServices {
    static func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
           fatalError("Bad request")
        }
        
        if httpResponse.statusCode != 200 {
            fatalError("Bad request")
        }else {
            return data
        }
    }
}
