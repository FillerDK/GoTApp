//
//  ContentView.swift
//  GoTApp
//
//  Created by dmu mac 32 on 18/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GoTView().environment(GoTController())
    }
}

#Preview {
    ContentView()
}
