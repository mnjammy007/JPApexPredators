//
//  PredatorDetail.swift
//  JPApexPredators18
//
//  Created by Apple on 23/10/24.
//

import SwiftUI
import MapKit
struct PredatorDetail: View {
    let predator: ApexPredator
    @State var position:MapCameraPosition
    
    var body: some View {
        GeometryReader {geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1)
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.66, height: geo.size.height * 0.3)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                    }
                    label:{
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                    }
                    .frame(height: 125)
                    .overlay(alignment: .trailing) {
                        Image(systemName: "greaterthan")
                            .opacity(0.5)
                            .imageScale(.large)
                            .font(.title3)
                            .padding(.trailing, 5)
                    }
                    .overlay(alignment: .topLeading) {
                        Text("Current Location")
                            .font(.title3)
                            .padding([.leading, .bottom], 5)
                            .padding([.trailing, .top], 5)
                            .background(.black.opacity(0.33))
                            .clipShape(.rect(bottomTrailingRadius: 15))
                    }
                    .clipShape(.rect(cornerRadius: 15))
                    
                    Text("Appears In:")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(predator.movies, id: \.self) {movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    Text("Movie Moments: ")
                        .font(.title)
                        .padding(.top, 15)
                    ForEach(predator.movieScenes) {movieScene in
                        Text(movieScene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(movieScene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    Text("Read More:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string:predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom)
                .frame(width: geo.size.width, alignment: .leading)
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack {
        PredatorDetail(predator: Predators().allApexPredators[2], position: .camera(MapCamera(centerCoordinate: Predators().allApexPredators[2].location, distance: 30000)))
            .preferredColorScheme(.dark)
    }
}
