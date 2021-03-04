//
//  GameStatusButton.swift
//  ConwaysGameOfLife
//
//  Created by Jeremy Yarley on 3/3/21.
//

import SwiftUI

struct GameStatusButton: View {
    
    //Properties
    @Binding var gameState: GameState
    
    //Computed Properties
    //Computed button color based on the game state
    var buttonColor: Color {
        switch gameState {
        case .seedPhase: return .green
        case .growing: return .blue
        case .gameOver: return .red
        }
    }
    
    var body: some View {
        //The VStack isn't "required" to build the view itself, but you can only have if statements
        //in a view if its inside of something like a VStack or HStack.
        VStack {
            //Switch doesn't work in views like this
            if gameState == .seedPhase {
                Text("Start Game").fontWeight(.bold)
            } else if gameState == .growing {
                Text("Next Generation").fontWeight(.bold)
            } else {
                Text("Restart Game").fontWeight(.bold)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 26)
        .padding(.vertical)
        .background(Capsule().foregroundColor(buttonColor)) //To make it look pretty
    }
}


struct GameStatusButton_Previews: PreviewProvider {
    static var previews: some View {
        GameStatusButton(gameState: .constant(.seedPhase))
    }
}
