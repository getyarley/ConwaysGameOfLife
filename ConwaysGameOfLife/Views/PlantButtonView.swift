//
//  PlantButtonView.swift
//  ConwaysGameOfLife
//
//  Created by Jeremy Yarley on 3/3/21.
//

import SwiftUI

//Reusable view for the alive/dead plant 
struct PlantButtonView: View {
    var plant: Plant
    
    var body: some View {
        //SF Symbols for alive or dead
        Image(systemName: plant.alive ? "leaf.fill" : "xmark.circle.fill")
            .resizable()
            .foregroundColor(plant.alive ? .green : .red) //Green = alive, Red = dead
    }
}

struct PlantButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlantButtonView(plant: Plant(alive: true, shouldChange: false))
    }
}
