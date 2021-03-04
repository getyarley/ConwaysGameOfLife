//
//  Garden.swift
//  ConwaysGameOfLife
//
//  Created by Jeremy Yarley on 3/3/21.
//

import Foundation


struct Garden {
    var plants: [[Plant]] //2D array of Plants to represent the board
}



//Garden functions
extension Garden {
    
    //Build Garden of size X by Y
    //This is run at the beginning of a game, all Plant values set to false
    func buildGarden(x: Int, y: Int) -> Garden {
        //Assumes x and y are greater than 0
        //Could add a guard statement here to confirm, then make the return type optional or return an error
        
        var newGarden: Garden = Garden(plants: [])
        for row in 0..<y {
            newGarden.plants.append([])
            for _ in 0..<x {
                newGarden.plants[row].append(Plant(alive: false, shouldChange: false))
            }
        }
        return newGarden
    }
    
    
    //Checks all of the neighbors for a given position (row x column) in the 2D array and returns the number of alive neighbors
    //Logic included to ignore the current plant (at position row x column)
    //Logic included to ignore walls (outside the range of the Garden 2D array, which would cause a fatal error)
    func checkNeighbors(row: Int, column: Int) -> Int {
        var aliveCount: Int = 0
        
        //Loop from the row above to the row below
        for y in (row - 1)...(row + 1) {
            if y >= 0 && y < self.plants.count { //Check that we're inside the bounds of the Garden array

                //Loop from the column on the left to the column on the right
                for x in (column - 1)...(column + 1) {
                    if x >= 0 && x < self.plants[0].count { //Check that we're inside the bounds of the Garden array
                        
                        //Checks that the plant at that location is alive AND that it's not the
                        //node being checked (at location row x column)
                        if self.plants[y][x].alive && !(y == row && x == column) {
                            aliveCount += 1 //Neighbor at location ([y][x]) is alive
                        }
                        
                    }
                }
            }
        }
        
        return aliveCount
    }
    
    
}
