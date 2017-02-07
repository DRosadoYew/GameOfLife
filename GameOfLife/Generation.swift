//
//  Generation.swift
//  GameOfLife
//
//  Created by Daniel Rosado on 05/02/17.
//  Copyright © 2017 Daniel Rosado. All rights reserved.
//

import Foundation

public struct Generation {
    private let cells: [[Cell]]
    
    public init?(cells: [[Cell]]) {
        guard Generation.cellGridIsRectangle(cells) else { return nil }
        
        self.cells = cells
    }
    
    // Note: Cannot have it as lazy var because ==() signature has non-mutating parameters.
    public func gridSize() -> CGSize {
        return CGSize(width: cells.first?.count ?? 0, height: cells.count)
    }
    
    public func gridWidth() -> Int {
        return Int(gridSize().width)
    }
    
    public func gridHeight() -> Int {
        return Int(gridSize().height)
    }
    
    public func cell(atRow row: Int, column: Int) -> Cell {
        // TODO: Bounds check
        return cells[row][column]
    }
    
    public func numberOfLivingNeighbors(ofCellAtRow row: Int, column: Int) -> Int {
        return livingNeighbors(ofCellAtRow: row, column: column).count
    }
    
    // TODO: Refactor
    func livingNeighbors(ofCellAtRow row: Int, column: Int) -> [Cell] {
        let topNeighbor = row-1 >= 0 ? cell(atRow: row-1, column: column) : nil
        let topLeftNeighbor = column-1 >= 0 && row-1 >= 0 ? cell(atRow: row-1, column: column-1) : nil
        let leftNeighbor = column-1 >= 0 ? cell(atRow: row, column: column-1) : nil
        let bottomLeftNeighbor = column-1 >= 0 && row+1 < gridHeight() ? cell(atRow: row+1, column: column-1) : nil
        let bottomNeighbor = row+1 < gridHeight() ? cell(atRow: row+1, column: column) : nil
        let bottomRightNeighbor = column+1 < gridWidth() && row+1 < gridHeight() ? cell(atRow: row+1, column: column+1) : nil
        let rightNeighbor = column+1 < gridWidth() ? cell(atRow: row, column: column+1) : nil
        let topRightNeighbor = column+1 < gridWidth() && row-1 >= 0 ? cell(atRow: row-1, column: column+1) : nil
        
        return [topNeighbor, topLeftNeighbor, leftNeighbor, bottomLeftNeighbor, bottomNeighbor, bottomRightNeighbor, rightNeighbor, topRightNeighbor].flatMap { $0 }.filter { $0 == .Living }
    }
            
    private static func cellGridIsRectangle(_ cells: [[Cell]]) -> Bool {
        // Return as not valid if no rows or the first row is empty (no columns).
        guard let cellsFirstRowWidth = cells.first?.count, cellsFirstRowWidth > 0 else { return false }
        
        // Return as not valid if there's rows with different number of columns. Valid otherwise.
        let invalidRows = cells.filter { $0.count != cellsFirstRowWidth }
        return invalidRows.count == 0
    }
}

extension Generation: Equatable {
    public static func ==(lhs: Generation, rhs: Generation) -> Bool {
        guard lhs.gridSize() == rhs.gridSize() else { return false }

        // Check that all rows have the same number of columns
        for rowIndex in 0..<lhs.gridHeight() {
            for columnIndex in 0..<lhs.gridWidth() {
                if lhs.cell(atRow: rowIndex, column: columnIndex) != rhs.cell(atRow: rowIndex, column: columnIndex) {
                    return false
                }
            }
        }
        
        return true
    }
}
