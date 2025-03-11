//
//  RoomSwiftDataApp.swift
//  RoomSwiftData
//
//  Created by Weerawut Chaiyasomboon on 11/03/2568.
//

import SwiftUI
import SwiftData

@main
struct RoomSwiftDataApp: App {
    
    init() {
        UIColorValueTransformer.register()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Room.self])
        }
    }
}


