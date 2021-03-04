//
//  ContentView.swift
//  ConwaysGameOfLife
//
//  Created by Jeremy Yarley on 3/3/21.
//

import SwiftUI

struct ContentView: View {
    
    //Variables
    @State var gameState: GameState = .seedPhase
    
    //2D array of Plants to represent the model for the game board
    //Built from buildGarden function, based on dimensions in Constants file
    @State var garden: Garden = {
        var garden = Garden(plants: [])
        garden = garden.buildGarden(x: Constants.width, y: Constants.height)
        return garden
    }()
    
    
    //MARK: View
    var body: some View {
        VStack {
            //MARK: Title
            Text("Conway's Game of Life")
                .font(.title)
            
            
            //MARK: Game Board
            GardenBoardView(garden: self.$garden, gameState: self.$gameState)
            
            Spacer()
            
            //MARK: Player Message
            //To provide direction for the player's input, based on gameState
            Text(gameState.rawValue)
                .font(.headline)
            
            
            //MARK: Game Status Button
            //This lets the player progress the game forward
            Button(action: {gameStatusButtonPressed()}) {
                GameStatusButton(gameState: $gameState)
            }
            
            
            //MARK: Reset Button
            Button(action: {resetGame()}) {
                Text("Reset")
                    .fontWeight(.semibold)
            }.padding()
            
        } //VSTACK
        .padding()
    }
}



//MARK: Functions
extension ContentView {
    
    //MARK: GameStatus Button Pressed
    //Determnines which function to call depending on what the current game status is
    func gameStatusButtonPressed() {
        switch gameState {
        case .seedPhase:
            self.gameState = .growing
            self.checkNeighbors()
        case .growing:
            self.checkNeighbors()
        case .gameOver:
            self.resetGame()
        }
    }
    
    
    //MARK: Reset
    //Reset the game so all Plants are dead and restart the seed phase
    func resetGame() {
        self.garden = garden.buildGarden(x: Constants.width, y: Constants.height)
        self.gameState = .seedPhase
    }
    
    
    //MARK: Check Neighbors
    //Determine if a plant should die, survive, or if a dead plant should revive.
    //Based on number of alive neighbors calculated from Garden function 'checkNeighbors'
    //NOTE: Plants are marked if they should change or not, not actually changed on the spot because that
    //      would affect following comparisons.
    func checkNeighbors() {
        //Loop through Garden
        for y in 0..<garden.plants.count {
            for x in 0..<garden.plants[0].count {
                //Determine how many neighboring Plants are alive
                let aliveNeighbors = garden.checkNeighbors(row: y, column: x)
                
                //Check if the Plant is dead AND has 3 alive neighbors
                if !garden.plants[y][x].alive && aliveNeighbors == 3 {
                    garden.plants[y][x].shouldChange = true //Bring dead plant back to life (later)
                    
                //Otherwise, if the Plant is alive and doesn't have 2 or 3 alive neighbors, it dies
                } else if garden.plants[y][x].alive && !(aliveNeighbors == 2 || aliveNeighbors == 3) {
                    garden.plants[y][x].shouldChange = true //The Plant dies (later)
                }
                //If neither of the conditions above are met, alive plants survive and dead plants stay dead
            }
        }
        
        self.flipPlants() //Actually change if the plants are alive or dead
    }
    
    
    //MARK: Flip Plants
    //Once plants are marked if they should be flipped (revived/killed), this actually does the flipping
    func flipPlants() {
        //Token to determine if no changes to the Plants are needed, this would trigger game over
        var gameOver = true
        
        //Loop through Garden
        for y in 0..<garden.plants.count {
            for x in 0..<garden.plants[0].count {
                if garden.plants[y][x].shouldChange {
                    garden.plants[y][x].alive.toggle() //Flip the Plant, Alive -> Dead, Dead -> Alive
                    garden.plants[y][x].shouldChange = false //Reset shouldChange property of the Plant
                    gameOver = false //At least 1 plant was flipped, so it's not game over
                }
            }
        }
        
        if gameOver {
            //This only captures of no plants changed state, but doesn't determine if all plants are dead
            self.gameState = .gameOver
        } else {
            //This check to see if all plants are dead
            lookForAlivePlants()
        }
    }
    
    
    //MARK: Look for Alive Plants
    //Check if any plants are alive, if all plants are dead then set to game over state
    func lookForAlivePlants() {
        //Token to determine if it's game over. Set to false if at least 1 plant is alive
        var gameOver = true
        
        //Loop through Garden
        for y in 0..<garden.plants.count {
            for x in 0..<garden.plants[0].count {
                if garden.plants[y][x].alive {
                    gameOver = false //Live plant found, game isn't over
                }
            }
        }
        
        if gameOver {
            //All plants are dead
            self.gameState = .gameOver
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
