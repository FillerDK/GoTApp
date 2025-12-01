import UIKit
import Foundation

@Observable
class GoTController {
    let dataSourceURL = URL(string: "https://thronesapi.com/api/v2/Characters")!
    var gotCharacters: [GoTCharacter] = []
    
    func getUIimage(for character: GoTCharacter) async throws -> UIImage? {
        let data = try await NetworkServices.fetchData(from: character.imageUrl)
        return UIImage(data: data)
    }
    
    /*
    func getGotImage(url: URL) async -> UIImage {
        let image = UIImage()
        do {
            _ = try await NetworkServices.fetchData(from: url)
            //image = try UIImage(data: data)!
        } catch {
            fatalError(error.localizedDescription)
        }
        return image
    }
    */
    
    func getGoTCharacters() async -> [GoTCharacter] {
        do {
            let data = try await NetworkServices.fetchData(from: dataSourceURL)
            let characters = try JSONDecoder().decode([GoTCharacter].self, from: data)
            return characters
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

