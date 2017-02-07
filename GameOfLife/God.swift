//
//  God.swift
//  GameOfLife
//
//  Created by Daniel Rosado on 06/02/17.
//  Copyright © 2017 Daniel Rosado. All rights reserved.
//

import Foundation

class God {
    // Only one :)
    static let sharedInstance = God()
    
    func createWorld(initialGeneration: Generation) -> World? {
        return World(god: self, generation: initialGeneration)
    }
    
    func evolvedGeneration(from generation: Generation) -> Generation {
        var nextGenerationCells = [[Cell]](repeatElement([Cell](repeatElement(.Dead,
                                                                count: generation.gridWidth())),
                                           count: generation.gridHeight()))
        
        for rowIndex in 0..<generation.gridHeight() {
            for columnIndex in 0..<generation.gridWidth() {
                let cell = generation.cell(atRow: rowIndex, column: columnIndex)
                let numberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: rowIndex, column: columnIndex)
                // TODO: Refactor:
                // Turn it into switch?
                // Extract the rule system to protocols?
                
                // The under-population rule
                // Note: this step could be removed, since all Cells start as .Dead.
                // More clearer when keeping it.
                if  cell == .Living && numberOfLivingNeighbors < 2 {
                    nextGenerationCells[rowIndex][columnIndex] = .Dead
                    continue
                }
                
                // The survival rule
                if cell == .Living && (numberOfLivingNeighbors == 2 || numberOfLivingNeighbors == 3) {
                    nextGenerationCells[rowIndex][columnIndex] = .Living
                    continue
                }
                
                // The overcrowding rule
                if cell == .Living && numberOfLivingNeighbors > 3 {
                    nextGenerationCells[rowIndex][columnIndex] = .Dead
                    continue
                }
                
                // The birth rule
                if cell == .Dead && numberOfLivingNeighbors == 3 {
                    nextGenerationCells[rowIndex][columnIndex] = .Living // \0/
                    continue
                }
            }
        }
        
        guard let nextGeneration = Generation(cells: nextGenerationCells) else { fatalError("Failed to create a valid next Generation") }
        
        return nextGeneration
    }
}
