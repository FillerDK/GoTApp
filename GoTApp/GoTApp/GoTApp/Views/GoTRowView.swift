//
//  GoTRowView.swift
//  GoTApp
//
//  Created by dmu mac 32 on 23/09/2025.
//

import SwiftUI

struct GoTRowView: View {
    let character: GoTCharacter

    var body: some View {
        Text(character.fullName)
    }
}

#Preview {
    GoTRowView(
        character:
            GoTCharacter(
                id: 2,
                firstName: "Jon",
                lastName: "Snow",
                fullName: "Jon Snow",
                title: "King in the North",
                family: "House Stark",
                image: "jon-snow.jpg",
                imageUrl: URL(string: "https://thronesapi.com/assets/images/jon-snow.jpg")!
            )
        
    )
}
