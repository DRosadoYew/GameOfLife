//
//  GodTests.swift
//  GameOfLife
//
//  Created by Daniel Rosado on 06/02/17.
//  Copyright © 2017 Daniel Rosado. All rights reserved.
//

import XCTest
@testable import GameOfLife

class GodTests: XCTestCase {
    func testCreate_whenGenerationIsValid_worldIsCreatedWithValidGenerationData() {
        // Arrange
        let initialGeneration = Generation(cells: [[.Living, .Living],
                                                   [.Dead, .Dead]])!
        
        // Act
        let world = God.sharedInstance.createWorld(initialGeneration: initialGeneration)
        
        // Assert
        XCTAssertNotNil(world)
        XCTAssertEqual(initialGeneration, world?.generation)
        XCTAssertEqual(1, world?.generationNumber)
    }
    
    // The under-population rule
    func testNext_whenGenerationLivingCellHasLessThen2LivingNeighbors_cellDies() {
        let currentGeneration = Generation(cells: [[.Living, .Living],
                                                   [.Dead, .Dead]])!
        let cellInTestBeforeEvolving = currentGeneration.cell(atRow: 0, column: 0)
        
        let nextGeneration = God.sharedInstance.evolvedGeneration(from: currentGeneration)
        
        XCTAssertEqual(.Living, cellInTestBeforeEvolving)
        let cellInTestAfterEvolving = nextGeneration.cell(atRow: 0, column: 0)
        XCTAssertEqual(.Dead, cellInTestAfterEvolving)
    }
    
    // The survival rule
    func testNext_whenGenerationLivingCellHas2or3LivingNeighbors_cellSurvives() {
        let generationWith2LivingNeighbors = Generation(cells: [[.Living, .Living],
                                                            [.Dead, .Living]])!
        let generationWith3LivingNeighbors = Generation(cells: [[.Living, .Living],
                                                            [.Living, .Living]])!
        let cellInTestForGenerationWith2 = generationWith2LivingNeighbors.cell(atRow: 0, column: 0)
        let cellInTestForGenerationWith3 = generationWith3LivingNeighbors.cell(atRow: 0, column: 0)
        
        
        let nextGenerationFromGenerationWith2 = God.sharedInstance.evolvedGeneration(from: generationWith2LivingNeighbors)
        let nextGenerationFromGenerationWith3 = God.sharedInstance.evolvedGeneration(from: generationWith3LivingNeighbors)
        
        
        XCTAssertEqual(.Living, cellInTestForGenerationWith2)
        let cellInTestAfterEvolvingGenerationWith2 = nextGenerationFromGenerationWith2.cell(atRow: 0, column: 0)
        XCTAssertEqual(.Living, cellInTestAfterEvolvingGenerationWith2)
        
        XCTAssertEqual(.Living, cellInTestForGenerationWith3)
        let cellInTestAfterEvolvingGenerationWith3 = nextGenerationFromGenerationWith3.cell(atRow: 0, column: 0)
        XCTAssertEqual(.Living, cellInTestAfterEvolvingGenerationWith3)
    }
    
    func testNext_whenGenerationDeadCellHas2LivingNeighbors_cellStaysDead() {
        let generationWith2LivingNeighbors = Generation(cells: [[.Dead, .Living],
                                                                [.Dead, .Living]])!
        let cellInTestForGenerationWith2 = generationWith2LivingNeighbors.cell(atRow: 0, column: 0)
        
        let nextGenerationFromGenerationWith2 = God.sharedInstance.evolvedGeneration(from: generationWith2LivingNeighbors)
        
        XCTAssertEqual(.Dead, cellInTestForGenerationWith2)
        let cellInTestAfterEvolvingGenerationWith2 = nextGenerationFromGenerationWith2.cell(atRow: 0, column: 0)
        XCTAssertEqual(.Dead, cellInTestAfterEvolvingGenerationWith2)
    }
    
    // The overcrowding rule
    func testNext_whenGenerationLivingCellHasMoreThan3LivingNeighbors_cellDies() {
        let generationWith4LivingNeighbors = Generation(cells: [[.Living, .Living, .Living],
                                                                [.Dead, .Living, .Living]])!
        let generationWith8LivingNeighbors = Generation(cells: [[.Living, .Living, .Living],
                                                                [.Living, .Living, .Living],
                                                                [.Living, .Living, .Living]])!
        let cellInTestForGenerationWith4 = generationWith4LivingNeighbors.cell(atRow: 0, column: 1)
        let cellInTestForGenerationWith8 = generationWith8LivingNeighbors.cell(atRow: 1, column: 1)
        
        
        let nextGenerationFromGenerationWith4 = God.sharedInstance.evolvedGeneration(from: generationWith4LivingNeighbors)
        let nextGenerationFromGenerationWith8 = God.sharedInstance.evolvedGeneration(from: generationWith8LivingNeighbors)
        
        
        XCTAssertEqual(.Living, cellInTestForGenerationWith4)
        let cellInTestAfterEvolvingGenerationWith4 = nextGenerationFromGenerationWith4.cell(atRow: 0, column: 1)
        XCTAssertEqual(.Dead, cellInTestAfterEvolvingGenerationWith4)
        
        XCTAssertEqual(.Living, cellInTestForGenerationWith8)
        let cellInTestAfterEvolvingGenerationWith8 = nextGenerationFromGenerationWith8.cell(atRow: 1, column: 1)
        XCTAssertEqual(.Dead, cellInTestAfterEvolvingGenerationWith8)
    }
    
    // The birth rule
    func testNext_whenGenerationDeadCellHas3LivingNeighbors_cellBecomesAlive() {
        let generationWithDeadCellAnd3LivingNeighbors = Generation(cells: [[.Living, .Living, .Living],
                                                                           [.Dead, .Living, .Living]])!
        let generationWithDeadCellAnd3LivingNeighbors_2 = Generation(cells: [[.Living, .Dead, .Living],
                                                                             [.Dead, .Dead, .Living]])!
        let cellInTestForGenerationWith3 = generationWithDeadCellAnd3LivingNeighbors.cell(atRow: 1, column: 0)
        let cellInTestForGenerationWith3_2 = generationWithDeadCellAnd3LivingNeighbors_2.cell(atRow: 0, column: 1)
        
        
        let nextGenerationFromGenerationWith3 = God.sharedInstance.evolvedGeneration(from: generationWithDeadCellAnd3LivingNeighbors)
        let nextGenerationFromGenerationWith3_2 = God.sharedInstance.evolvedGeneration(from: generationWithDeadCellAnd3LivingNeighbors_2)
        
        
        XCTAssertEqual(.Dead, cellInTestForGenerationWith3)
        let cellInTestAfterEvolvingGenerationWith3 = nextGenerationFromGenerationWith3.cell(atRow: 1, column: 0)
        XCTAssertEqual(.Living, cellInTestAfterEvolvingGenerationWith3)
        
        XCTAssertEqual(.Dead, cellInTestForGenerationWith3_2)
        let cellInTestAfterEvolvingGenerationWith3_2 = nextGenerationFromGenerationWith3_2.cell(atRow: 0, column: 1)
        XCTAssertEqual(.Living, cellInTestAfterEvolvingGenerationWith3_2)
    }    
}
