//
//  ListDemo.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct ListDemo: View {
    @State var nums: [Int] = Array(1...10)
    @State var nums2: [Int] = Array(11...20)
    
    @State var items: [Item] = [
        .init(title: "a"),
        .init(title: "b"),
        .init(title: "c")
    ]
    
    struct NotHashableStruct: Equatable {
        let id = UUID()
        
        static func == (lhs: NotHashableStruct, rhs: NotHashableStruct) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    struct Item: Identifiable, Hashable {
        let id = UUID()
        var title: String
        let notHashable: NotHashableStruct = .init()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
        }
    }
    
    var body: some View {
        List {
            Section(header: Text("FIRST")) {
                ForEach(nums, id: \.self) {
                    Text("\($0)")
                        .font(.system(size: 30))
                }
                .onDelete { toDelete in
                    nums.remove(atOffsets: toDelete)
                }
            }
        
            Section(header: Text("SECOND")) {
                ForEach(items) { item in
                    Text("\(item.title)")
                        .font(.system(size: 30))
                        .onTapGesture {
                            items.replace([item], with: [.init(title: "0")])
                            print("TAPPED", "\(item.title)")
                        }
                }
                .onMove { from, to in
                    items.move(fromOffsets: from, toOffset: to)
                }
            }
            
            Section(header: Text("THIRD")) {
                ForEach($items) { $item in
                    Text("\(item.title)")
                        .font(.system(size: 30))
                        .onTapGesture {
                            item.title = "0"
                            print("TAPPED", "\(item.title)")
                        }
                }
                .onMove { from, to in
                    items.move(fromOffsets: from, toOffset: to)
                }
            }
        }
        .listStyle(.plain)
        .padding()
    }
}

#Preview {
    ListDemo()
}
