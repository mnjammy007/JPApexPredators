//
//  Predators.swift
//  JPApexPredators18
//
//  Created by Apple on 22/10/24.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
            }
            catch {
                print("Error decoding the data \(error)")
            }
        }
    }
    
    func search(for searchQuery:String) -> [ApexPredator] {
        if searchQuery.isEmpty {
            return apexPredators
        }
        else {
            return apexPredators.filter{ predator in
                predator.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    
    func sortPredator(isSortByAlphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if isSortByAlphabetical{
                predator1.name < predator2.name
            }
            else{
                predator1.id < predator2.id
            }
        }
    }
}
