import SwiftUI

struct ContentView: View {
    var body: some View {
        GoTView().environment(GoTController())
    }
}

#Preview {
    ContentView()
}
