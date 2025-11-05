//
//  ContentView.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct ContentView: View {
    let persistenceController = CoreDataStack.shared

    var body: some View {
        PokedexList()
            .environment(\.managedObjectContext, persistenceController.context)
    }
}

#Preview {
    ContentView()
}
