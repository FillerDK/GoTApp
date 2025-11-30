//
//  GoTModel.swift
//  GoTApp
//
//  Created by dmu mac 32 on 18/09/2025.
//

import Foundation

struct GoTCharacter: Codable, Identifiable, Hashable {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let title: String
    let family: String
    let image: String
    let imageUrl: URL
    
    //var image: UIImage?
}
