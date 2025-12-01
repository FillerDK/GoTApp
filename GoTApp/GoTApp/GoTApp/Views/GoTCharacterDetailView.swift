import SwiftUI

struct GoTCharacterDetailView: View {
    let GoTCharacter: GoTCharacter
    @State private var image: UIImage?
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                }
                AsyncImage(url: GoTCharacter.imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .frame(width: 300, height: 300)
        .cornerRadius(20)
        .onAppear(
            /*
            Task {
                /*
                if let image = GoTCharacter.image {
                    self.image = image
                } else {
                    image = await controller.getGotImage(url: GoTCharacter.imageURL)
                }
                */
                image = await controller.getGotImage(url: GoTCharacter.imageURL)
            }
            */
        )
    }
}

#Preview {
    GoTCharacterDetailView(
        GoTCharacter:
            GoTCharacter(
                id: 99,
                firstName: "Fornavn",
                lastName: "Efternavn",
                fullName: "Fuldnavn",
                title: "Titel",
                family: "Familie",
                image: "ornavn-efternavn.jpg",
                imageUrl: URL(string: "https://thronesapi.com/assets/images/daenerys.jpg")!
            )
    )
}
