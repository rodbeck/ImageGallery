//
//  Item.swift
//  ImageGallery
//
//  Created by Rodolphe Beck on 23/06/2024.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable {
    let id = UUID()
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
