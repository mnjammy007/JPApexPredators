//
//  PredatorMap.swift
//  JPApexPredators18
//
//  Created by Apple on 23/10/24.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators: [ApexPredator] = Predators().allApexPredators
    @State var position: MapCameraPosition
    @State var isSatteliteViewActive = false
    @State var isPopOverVisible = false
    
    var body: some View {
        Map(position: $position){
            ForEach(predators) { predator in
                Annotation(predator.name, coordinate: predator.location) {
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                        .onTapGesture {
                            isPopOverVisible.toggle()
                        }
                        .popover(isPresented: $isPopOverVisible, arrowEdge: .bottom) {
                            VStack {
                                HStack {
                                    Text(predator.name)
                                        .font(.title)
                                    Text(" - \(predator.type.rawValue)")
                                        .font(.title3)
                                }
                                .padding()
                            }
                            .presentationCompactAdaptation(.popover)
                        }
                }
            }
        }
        .mapStyle(isSatteliteViewActive ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                isSatteliteViewActive.toggle()
            }
            label: {
                Image(systemName: isSatteliteViewActive ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().allApexPredators[2].location, distance: 1000, heading: 250, pitch: 80))
    )
        .preferredColorScheme(.dark)
}
