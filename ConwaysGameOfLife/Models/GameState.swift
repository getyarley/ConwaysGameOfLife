//
//  GameState.swift
//  ConwaysGameOfLife
//
//  Created by Jeremy Yarley on 3/3/21.
//

import Foundation

//Enum to distinguish the state of the game, whether the user is adding the seeds,
//watching the plants grow or die, or if its game over.
//Strings included as message to the player, see ContentView Player Message
enum GameState: String {
    case seedPhase = "Tap Plants to set up the Garden"
    case growing = "How long will your Garden survive?"
    case gameOver = "Game Over!"
}
