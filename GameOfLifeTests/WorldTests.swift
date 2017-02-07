//
//  WorldTests.swift
//  GameOfLifeTests
//
//  Created by Daniel Rosado on 05/02/17.
//  Copyright © 2017 Daniel Rosado. All rights reserved.
//

import XCTest
@testable import GameOfLife

class WorldTests: XCTestCase {
    let god = God.sharedInstance
    
    func testInit_whenGenerationIsProvided_worldIsCreatedWithGenerationNumber1() {
        // Arrange
        guard let generation = Generation(cells: [[true]]) else { XCTFail(); return }
        
        // Act
        let world = World(god: god, generation: generation)
        
        // Assert
        XCTAssertNotNil(world)
        XCTAssertEqual(1, world.generationNumber)
    }
    
    func testEvolve_whenGenerationIsUpdated_worldIncreasesGenerationNumber() {
        guard let generation = Generation(cells: [[true]]) else { XCTFail(); return }
        var world = World(god: god, generation: generation)
        
        world.evolve()
        
        XCTAssertEqual(2, world.generationNumber)
        XCTAssertNotNil(world.generation)
    }
    
    func testEvolve_whenGenerationHasOneLiveCell_nextGenerationHasOneDeadCell() {
        guard let generation = Generation(cells: [[true]]) else { XCTFail(); return }
        var world = World(god: god, generation: generation)
        
        world.evolve()
        
        let cellInNewGeneration = world.generation.cell(atRow: 0, column: 0)
        XCTAssertEqual(.Dead, cellInNewGeneration)
    }
    
    func testEvolve_whenGenerationHasOneDeadCell_nextGenerationHasOneDeadCell() {
        guard let generation = Generation(cells: [[.Dead]]) else { XCTFail(); return }
        var world = World(god: god, generation: generation)
        
        world.evolve()
        
        let cellInNewGeneration = world.generation.cell(atRow: 0, column: 0)
        XCTAssertEqual(.Dead, cellInNewGeneration)
    }
        
    func testEvolve_whenAskedToEvolve_nextGenerationIsValid() {
        let cells: [[Cell]] = [[.Living, .Living, .Living],
                               [.Living, .Living, .Living],
                               [.Living, .Living, .Living]]
        guard let generation = Generation(cells: cells) else { XCTFail(); return }
        var world = World(god: god, generation: generation)
        
        // Second generation
        world.evolve()
        let secondGeneration = world.generation
        XCTAssertEqual(Generation(cells: [[.Living, .Dead, .Living],
                                          [.Dead, .Dead, .Dead],
                                          [.Living, .Dead, .Living]]),
                       secondGeneration)
        
        // Third generation
        world.evolve()
        let thirdGeneration = world.generation
        XCTAssertEqual(Generation(cells: [[.Dead, .Dead, .Dead],
                                          [.Dead, .Dead, .Dead],
                                          [.Dead, .Dead, .Dead]]),
                       thirdGeneration)
        
        // Fourth generation
        world.evolve()
        let fourthGeneration = world.generation
        XCTAssertEqual(Generation(cells: [[.Dead, .Dead, .Dead],
                                          [.Dead, .Dead, .Dead],
                                          [.Dead, .Dead, .Dead]]),
                       fourthGeneration)
    }
}
