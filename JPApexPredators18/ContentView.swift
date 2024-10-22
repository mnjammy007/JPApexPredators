//
//  ContentView.swift
//  JPApexPredators18
//
//  Created by Apple on 16/10/24.
//

import SwiftUI

struct ContentView: View {
    let predators = Predators()
    @State var isSortByAlphabetical = false
    @State var searchQuery = ""
    
    var filteredDinos: [ApexPredator] {
        predators.sortPredator(isSortByAlphabetical: isSortByAlphabetical)
        return predators.search(for: searchQuery)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinos) { predator in
                NavigationLink {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                }
                label : {
                    HStack {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack(alignment: .leading) {
                            Text(predator.name)
                                .fontWeight(.bold)
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchQuery)
            .autocorrectionDisabled()
            .animation(.default, value: searchQuery)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isSortByAlphabetical.toggle()
                    }
                    label:{
                        isSortByAlphabetical ? Image(systemName: "film") : Image(systemName: "textformat")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
