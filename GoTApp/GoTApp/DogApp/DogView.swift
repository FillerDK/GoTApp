import SwiftUI

struct DogView: View {
    @State private var controller = DogController()

    var body: some View {
        NavigationStack {
            List(controller.items) { item in
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.dogType)
                        .font(.title3)
                        .textSelection(.enabled)

                    Image(uiImage: item.image)
                        .resizable()
                        .scaledToFit()
                        .border(Color.black, width: 10)
                        .cornerRadius(10)
                }
                .padding(.vertical, 8)
            }
            .listStyle(.plain)
            .overlay {
                if controller.items.isEmpty {
                    ProgressView("Loading dogs…")
                }
            }
            .task {
                controller.fetchThreeDogs()
            }
            .toolbar {
                Button("Reload") {
                    controller.fetchThreeDogs()
                }
            }
            .navigationTitle(Text("Dogs"))
        }
    }
}

#Preview {
    DogView()
}

