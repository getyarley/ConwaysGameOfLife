//
//  GardenView.swift
//  ConwaysGameOfLife
//
//  Created by Jeremy Yarley on 3/3/21.
//

import SwiftUI

struct GardenBoardView: View {
    
    //Properties - Bound to ContentView so they react to changes automatically
    @Binding var garden: Garden
    @Binding var gameState: GameState
    
    
    //These views can be split up into different files for organization, but for simplicity
    //and readability, I kept them in one spot
    var body: some View {
        //Build in geometry reader to scale the buttons based on # of columns and screen size
        GeometryReader { geometry in
            
            //Wrapped in a scroll view in case there are more rows extend further than the bounds
            ScrollView {
            //VStack for each row
                VStack(spacing: 0) {
                    ForEach(0..<garden.plants.count) { row in
                        
                        //HStack for each button in the row
                        HStack(spacing: 0) {
                            ForEach(0..<garden.plants[0].count) { column in
                                
                                //Use row and column to toggle the alive property at that location
                                Button(action: {self.garden.plants[row][column].alive.toggle()}) {
                                    PlantButtonView(plant: garden.plants[row][column])
                                        //Scale button based on width of view and number of buttons
                                        .frame(width: geometry.size.width / CGFloat(Constants.width), height: geometry.size.width / CGFloat(Constants.width))
                                } //BUTTON
                                .disabled(self.gameState != .seedPhase) //Disable the buttons unless in the seed phase
                                
                            } //FOREACH
                        } //HSTACK
                    } //FOREACH
                } //VSTACK
            } //SCROLLVIEW
        } //GEOMETRYREADER
    }
}




struct GardenBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GardenBoardView(garden: .constant(Garden(plants: [])), gameState: .constant(.seedPhase))
    }
}
