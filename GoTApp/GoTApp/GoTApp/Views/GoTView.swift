import SwiftUI

struct GoTView: View {
    @Environment(GoTController.self) private var controller: GoTController

    var body: some View {
        NavigationStack {
            List(controller.gotCharacters) { character in
                NavigationLink(value: character) {
                    GoTRowView(character: character)
                }
            }
            .task {
                let characters = await controller.getGoTCharacters()
                controller.gotCharacters = characters
            }
            .navigationDestination(for: GoTCharacter.self) { theCharacter in
                GoTCharacterDetailView(GoTCharacter: theCharacter)
            }
            .navigationTitle("Game of Thrones")
        }
    }
}

#Preview {
    GoTView()
        .environment(GoTController())
}
