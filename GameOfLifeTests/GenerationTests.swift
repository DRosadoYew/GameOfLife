//
//  GenerationTests.swift
//  GameOfLife
//
//  Created by Daniel Rosado on 05/02/17.
//  Copyright © 2017 Daniel Rosado. All rights reserved.
//

import XCTest
@testable import GameOfLife

class GenerationTests: XCTestCase {
    // Init
    func testInit_whenEmptyCellGrid_generationIsNotCreated() {
        let cells = [[Cell]]()
        
        let generation = Generation(cells: cells)
        
        XCTAssertNil(generation)
    }
    
    func testInit_whenCellGridFirstRowIsEmpty_generationIsNotCreated() {
        let cellsNoRectangle: [[Cell]] = [[]]
        
        let generation = Generation(cells: cellsNoRectangle)
        
        XCTAssertNil(generation)
    }
    
    func testInit_whenCellGridDoesNotFormARectangle_generationIsNotCreated() {
        let cellsNoRectangle: [[Cell]] = [[true], []]
        
        let generation = Generation(cells: cellsNoRectangle)
        
        XCTAssertNil(generation)
    }
    
    func testInit_whenCellsFormARectangle_generationIsCreated() {
        let cellsRectangle: [[Cell]] = [[true], [true]]
        
        let generation = Generation(cells: cellsRectangle)
        
        XCTAssertNotNil(generation)
    }
    
    func testGridWidth_whenGridHas2columns_gridWidthIs2() {
        let generation = Generation(cells: [[true, true]])
        
        XCTAssertEqual(2, generation?.gridWidth())
    }
    
    func testGridHeight_whenGridHas2rows_gridHeightIs2() {
        let generation = Generation(cells: [[true], [true]])
        
        XCTAssertEqual(2, generation?.gridHeight())
    }
    
    
    // Equality
    func testEquals_whenBothGenerationsAreEmpty_areEqual() {
        let generation1 = Generation(cells: [[]])
        let generation2 = Generation(cells: [[]])
        
        XCTAssertEqual(generation1, generation2)
    }
    
    func testEquals_whenBothGenerationsHaveOneDeadCellOnTheFirstSquare_areEqual() {
        let generation1 = Generation(cells: [[false]])
        let generation2 = Generation(cells: [[false]])
        
        XCTAssertEqual(generation1, generation2)
    }
    
    func testEquals_whenGenerationsHaveDifferentGridSize_areNotEqual() {
        let generation1 = Generation(cells: [[true, false]])
        let generation2 = Generation(cells: [[true]])
        
        XCTAssertNotEqual(generation1, generation2)
    }
    
    func testEquals_whenGenerationsHaveDifferentCellValues_areNotEqual() {
        let generation1 = Generation(cells: [[true]])
        let generation2 = Generation(cells: [[false]])
        
        XCTAssertNotEqual(generation1, generation2)
    }
    
    
    // Neighbors
    func testNeighbors_whenCellHasNoNeighbors_ReturnsEmptyArray() {
        let generation = Generation(cells: [[true]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 0, column: 0)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 0)
    }
    
    func testNeighbors_whenCellHasNoLivingNeighbors_ReturnsEmptyArray() {
        let generation = Generation(cells: [[false, false, false], [false, true, false], [false, false, false]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 0)
    }
    
    func testNeighbors_whenCellHasOnly1TopLivingNeighbor_ReturnsALivingNeighbor() {
        let generation = Generation(cells: [[true], [true]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 1, column: 0)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 1)
    }
    
    func testNeighbors_whenCellHasOnly1BottomLivingNeighbor_ReturnsALivingNeighbor() {
        let generation = Generation(cells: [[false, false, false], [false, true, false], [false, false, false]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 0, column: 1)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 1)
    }
    
    func testNeighbors_whenCellHasOnly1LeftLivingNeighbor_ReturnsALivingNeighbor() {
        let generation = Generation(cells: [[false, false, false], [false, false, false], [false, true, false]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 2, column: 2)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 1)
    }
    
    func testNeighbors_whenCellHasOnly1RightLivingNeighbor_ReturnsALivingNeighbor() {
        let generation = Generation(cells: [[false, true, false], [false, false, false], [false, false, false]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 0, column: 0)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 1)
    }
    
    func testNeighbors_whenCellHasOnly1TopLeftLivingNeighbor_ReturnsALivingNeighbor() {
        let generation = Generation(cells: [[true, false, false], [false, false, false], [false, false, false]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 1)
    }
    
    func testNeighbors_whenCellHasOnly1BottomLeftLivingNeighbor_ReturnsALivingNeighbor() {
        let generation = Generation(cells: [[false, false, false], [false, true, false], [false, false, false]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 0, column: 1)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 1)
    }
    
    func testNeighbors_whenCellHasOnly1BottomRightLivingNeighbor_ReturnsALivingNeighbor() {
        let generation = Generation(cells: [[false, false, false], [false, true, false], [false, false, true]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 1)
    }
    
    func testNeighbors_whenCellHasOnly1TopRightLivingNeighbor_ReturnsALivingNeighbor() {
        let generation = Generation(cells: [[false, false, false], [false, false, true], [false, false, false]])!
        
        let cellNumberOfLivingNeighbors = generation.numberOfLivingNeighbors(ofCellAtRow: 2, column: 1)
        
        XCTAssertTrue(cellNumberOfLivingNeighbors == 1)
    }
    
    func testNeighbors_whenCellHas2LivingNeighbors_Returns2LivingNeighbors() {
        let generationHorizontal = Generation(cells: [[true, false, true], [false, false, false], [true, true, true]])!
        let generationCorners = Generation(cells: [[false, false, false], [true, false, true], [true, true, true]])!
        let generationVertical = Generation(cells: [[false, true, false], [false, true, false], [false, true, false]])!
        
        let cellNumberOfLivingNeighborsHorizontal = generationHorizontal.numberOfLivingNeighbors(ofCellAtRow: 0, column: 1)
        let cellNumberOfLivingNeighborsCorners = generationCorners.numberOfLivingNeighbors(ofCellAtRow: 0, column: 1)
        let cellNumberOfLivingNeighborsVertical = generationVertical.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        
        
        XCTAssertTrue(cellNumberOfLivingNeighborsHorizontal == 2)
        XCTAssertTrue(cellNumberOfLivingNeighborsCorners == 2)
        XCTAssertTrue(cellNumberOfLivingNeighborsVertical == 2)
    }
    
    func testNeighbors_whenCellHas3LivingNeighbors_Returns3LivingNeighbors() {
        let generationHorizontalTop = Generation(cells: [[false, true, false], [true, false, true], [false, false, false]])!
        let generationTopCornersBottom = Generation(cells: [[true, false, true], [false, true, false], [false, true, false]])!
        let generationVerticalBottomRightCorner = Generation(cells: [[false, true, false], [false, false, false], [false, true, true]])!
        
        let cellNumberOfLivingNeighborsHorizontalTop = generationHorizontalTop.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        let cellNumberOfLivingNeighborsTopCornersBottom = generationTopCornersBottom.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        let cellNumberOfLivingNeighborsVerticalBottomRightCorner = generationVerticalBottomRightCorner.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        
        XCTAssertTrue(cellNumberOfLivingNeighborsHorizontalTop == 3)
        XCTAssertTrue(cellNumberOfLivingNeighborsTopCornersBottom == 3)
        XCTAssertTrue(cellNumberOfLivingNeighborsVerticalBottomRightCorner == 3)
    }
    
    func testNeighbors_whenCellHasMoreThan3LivingNeighbors_ReturnsMoreThan3LivingNeighbors() {
        let generation5LivingNeighbors = Generation(cells: [[true, true, true], [true, true, true], [true, true, true]])!
        let generation6LivingNeighbors = Generation(cells: [[true, true, true], [true, true, true], [false, true, false]])!
        let generation7LivingNeighbors = Generation(cells: [[true, true, true], [true, true, true], [true, true, false]])!
        let generation8LivingNeighbors = Generation(cells: [[true, true, true], [true, true, true], [true, true, true]])!
        
        let cell5NumberOfLivingNeighbors = generation5LivingNeighbors.numberOfLivingNeighbors(ofCellAtRow: 0, column: 1)
        let cell6NumberOfLivingNeighbors = generation6LivingNeighbors.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        let cell7NumberOfLivingNeighbors = generation7LivingNeighbors.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        let cell8NumberOfLivingNeighbors = generation8LivingNeighbors.numberOfLivingNeighbors(ofCellAtRow: 1, column: 1)
        
        XCTAssertTrue(cell5NumberOfLivingNeighbors == 5)
        XCTAssertTrue(cell6NumberOfLivingNeighbors == 6)
        XCTAssertTrue(cell7NumberOfLivingNeighbors == 7)
        XCTAssertTrue(cell8NumberOfLivingNeighbors == 8)
    }
    
    
}





