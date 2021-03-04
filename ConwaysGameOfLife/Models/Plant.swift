//
//  Plant.swift
//  ConwaysGameOfLife
//
//  Created by Jeremy Yarley on 3/3/21.
//

import Foundation


struct Plant: Hashable {
    
    var alive: Bool
    var shouldChange: Bool //To indicate if the alive state needs to change based on its neighbors
    //^ see 'checkNeighbors' function in 'Garden'
    
}
