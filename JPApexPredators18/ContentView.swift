//
//  ContentView.swift
//  JPApexPredators18
//
//  Created by Apple on 16/10/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    @State var isSortByAlphabetical = false
    @State var searchQuery = ""
    @State var currenntSelectedType = PredatorType.all
    
    var filteredDinos: [ApexPredator] {
        predators.filterPredator(by: currenntSelectedType)
        predators.sortPredator(isSortByAlphabetical: isSortByAlphabetical)
        return predators.search(for: searchQuery)
    }
    
    var body: some View {
        NavigationStack{
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
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
                        withAnimation {
                            isSortByAlphabetical.toggle()
                        }
                    }
                    label:{
                         Image(systemName: isSortByAlphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: isSortByAlphabetical)
                    }
                }
                ToolbarItem (placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currenntSelectedType.animation()) {
                            ForEach(PredatorType.allCases) { predatorType in
                                Label(predatorType.rawValue.capitalized, systemImage: predatorType.filterIcon)
                                
                            }
                        }
                    }
                    label: {Image(systemName: "slider.horizontal.3")}
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
