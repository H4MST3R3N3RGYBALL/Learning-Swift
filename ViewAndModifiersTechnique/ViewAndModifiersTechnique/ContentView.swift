//
//  ContentView.swift
//  ViewAndModifiersTechnique
//
//  Created by h4mst3r on 12/3/22.
//

import SwiftUI

struct ContentView: View {
    struct GridStack<Content: View>: View {
        let rows: Int
        let columns: Int
        let content: (Int, Int) -> Content
        
        var body: some View {
            VStack {
                ForEach(0 ..< columns, id: \.self) { row in
                    HStack {
                        ForEach(0 ..< columns, id: \.self) { column in
                            content(row, column)
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            HStack {
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
