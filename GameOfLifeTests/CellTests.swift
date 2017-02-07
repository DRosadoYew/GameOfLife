//
//  CellTests.swift
//  GameOfLife
//
//  Created by Daniel Rosado on 06/02/17.
//  Copyright © 2017 Daniel Rosado. All rights reserved.
//

import XCTest
@testable import GameOfLife

class CellTests: XCTestCase {
    func testInit_whenCreatingLiveCellFromBoolTrue_cellIsAlive() {
        let cell: Cell = true
        
        XCTAssertEqual(cell, .Living)
    }
    
    func testInit_whenCreatingLiveCellFromBoolFalse_cellIsDead() {
        let cell: Cell = false
        
        XCTAssertEqual(cell, .Dead)
    }
}
