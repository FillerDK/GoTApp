import Foundation
import SwiftUI

struct DogItem: Equatable, Identifiable, Hashable {
    
    static func == (lhs: DogItem, rhs: DogItem) -> Bool {
        lhs.dogType == rhs.dogType && lhs.dog.id == rhs.dog.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(dogType)
        hasher.combine(dog.id)
    }
    
    let dogType: String
    let image: UIImage
    let dog: Dog

    var id: String { dog.id }
}

@Observable
class DogController {
    // New single source of truth for the view
    var items: [DogItem] = []

    func fetchDog() async throws -> Dog {
        let dogURL = URL(string: "https://dog.ceo/api/breeds/image/random")!
        let (data, _) = try await URLSession.shared.data(from: dogURL)
        return try JSONDecoder().decode(Dog.self, from: data)
    }

    func fetchImage(for url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeRawData)
        }
        return image
    }
    
    private func breed(from url: URL) -> String {
        // Example path: /breeds/hound-afghan/n02088094_1003.jpg
        let components = url.pathComponents
        if let breedsIndex = components.firstIndex(of: "breeds"),
           components.indices.contains(components.index(after: breedsIndex)) {
            let breedFolder = components[components.index(after: breedsIndex)]
            // If you only want the main breed (before any "-"), uncomment next line:
            // return breedFolder.split(separator: "-").first.map(String.init) ?? "unknown"
            return breedFolder
        }
        return "unknown"
    }

    // Public API used by the view
    func fetchThreeDogs() {
        Task {
            do {
                async let first = fetchDog()
                async let second = fetchDog()
                async let third = fetchDog()

                let fetchedDogs = try await [first, second, third]

                // Fetch images in parallel and build DogItem list
                let newItems = try await withThrowingTaskGroup(of: DogItem.self) { group in
                    for dog in fetchedDogs {
                        group.addTask {
                            let image = try await self.fetchImage(for: dog.url)
                            let dogType = await self.breed(from: dog.url)
                            return DogItem(dogType: dogType, image: image, dog: dog)
                        }
                    }

                    var collected: [DogItem] = []
                    for try await item in group {
                        collected.append(item)
                    }
                    return collected
                }

                // Publish to the view
                self.items = newItems
            } catch {
                // Handle errors appropriately (e.g., set an error state)
                print("Failed to fetch dogs: \(error)")
                self.items = []
            }
        }
    }
}
