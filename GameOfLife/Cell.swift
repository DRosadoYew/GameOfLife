//
//  Cell.swift
//  GameOfLife
//
//  Created by Daniel Rosado on 06/02/17.
//  Copyright © 2017 Daniel Rosado. All rights reserved.
//

import Foundation

public enum Cell {
    case Living
    case Dead
}

extension Cell: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = value ? .Living : .Dead
    }
}
