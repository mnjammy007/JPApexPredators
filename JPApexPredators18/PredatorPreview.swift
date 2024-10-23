//
//  PredatorPreview.swift
//  JPApexPredators18
//
//  Created by Apple on 23/10/24.
//

import SwiftUI

struct PredatorPreview: View {
    let predator: ApexPredator
    
    var body: some View {
        VStack {
            
            Image(predator.image)
                .resizable()
                .scaledToFit()
                .scaleEffect(x:-1)
            Text(predator.name)
                .font(.largeTitle)
                .padding(.top)
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack{
        PredatorPreview(predator: Predators().allApexPredators[0])
            .preferredColorScheme(.dark)
    }
}
