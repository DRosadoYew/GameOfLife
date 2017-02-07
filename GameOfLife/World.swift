//
//  World.swift
//  GameOfLife
//
//  Created by Daniel Rosado on 05/02/17.
//  Copyright © 2017 Daniel Rosado. All rights reserved.
//

import Foundation

struct World {
    let god: God
    
    // TODO: Make it thread-safe or have the generation number as part
    // of the Generation. What about equality then?
    var generation: Generation {
        didSet {
            generationNumber = generationNumber + 1
        }
    }
    var generationNumber: Int = 0
    
    init(god: God, generation: Generation) {
        self.god = god        
        self.generation = generation
        generationNumber = 1
    }
    
    mutating func evolve() {
        generation = god.evolvedGeneration(from: generation)
    }    
}
