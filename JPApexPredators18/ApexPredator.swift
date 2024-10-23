//
//  ApexPredator.swift
//  JPApexPredators18
//
//  Created by Apple on 16/10/24.
//
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable{
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    struct MovieScene: Decodable, Identifiable{
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: PredatorType{
        self
    }
    
    var background: Color{
        switch self{
        case .land:
                .brown
        case .air:
                .teal
        case .sea:
                .blue
        case .all:
                .black // It wouldn't matter as no dyno is of all type but this will help in filter by type
        }
    }
    
    var filterIcon : String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
    
//    var predatorBgImage: ImageResource{
//        switch self {
//        case .all:
//                .land
//        case .land:
//                .land
//        case .air:
//                .air
//        case .sea:
//                .sea
//        }
//    }
//    This is not required as predator.type.rawValue will work, as it is same a image resource name
}
