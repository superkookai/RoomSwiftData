//
//  ContentView.swift
//  RoomSwiftData
//
//  Created by Weerawut Chaiyasomboon on 11/03/2568.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var name: String = ""
    @State private var color: Color = .red
    
    @Environment(\.modelContext) var context
    @Query var rooms: [Room] = []
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("Rooms")
                    .font(.largeTitle)
                
                Spacer()
                
                Button {
                    let room = Room(name: self.name, color: UIColor(self.color))
                    context.insert(room)
                    self.name = ""
                    do {
                        try context.save()
                    } catch {
                        fatalError("Cannot save room")
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
            }
            
            TextField("Room Name", text: $name)
                .font(.title)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.bottom)
            
            ColorSelector(selectedColor: $color)
            
            if rooms.isEmpty {
                ContentUnavailableView("No rooms in database", systemImage: "list.dash.header.rectangle")
            } else {
                List(rooms) { room in
                    RoomRowView(room: room)
                }
                .listStyle(.plain)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Room.self])
}

struct ColorSelector: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [.red,.green,.blue,.orange,.gray,.teal,.brown,.purple,.pink,.indigo,.cyan]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Color Selector")
                    .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 70)
                            .overlay(content: {
                                selectedColor == color ? Circle().stroke(lineWidth: 1) : nil
                            })
                            .onTapGesture {
                                self.selectedColor = color
                            }
                    }
                }
            }
        }
    }
}

#Preview("Color Selector") {
    ColorSelector(selectedColor: .constant(.red))
}

struct RoomRowView: View {
    let room: Room
    
    var body: some View {
        HStack {
            Text(room.name.capitalized)
            Spacer()
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(uiColor: room.color))
                .frame(width: 70, height: 70)
        }
    }
}
