//
//  Room.swift
//  RoomSwiftData
//
//  Created by Weerawut Chaiyasomboon on 11/03/2568.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Room {
    
    var name: String
    
    @Attribute(.transformable(by: UIColorValueTransformer.self))
    var color: UIColor
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}
