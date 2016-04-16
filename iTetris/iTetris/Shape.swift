//
//  Shape.swift
//  iTetris
//
//  Created by Bruno Da luz on 16/04/16.
//  Copyright © 2016 Bruno v0id. All rights reserved.
//

import SpriteKit

let numOrientations: UInt32 = 4

enum Orientation: Int, CustomStringConvertible {
    case Zero = 0, Ninety, OneEighty, TwoSeventy
    
    var description: String {
        switch self {
        case .Zero:
            return "0"
        
        case .Ninety:
            return "90"
            
        case .OneEighty:
            return "180"
            
        case .TwoSeventy:
            return "270"
        }
    }
    
    static func random() -> Orientation {
        return Orientation(rawValue: Int(arc4random_uniform(numOrientations)))!
    }
    
    static func rotate(orientation: Orientation, clockwise: Bool) -> Orientation {
        var rotated = orientation.rawValue + (clockwise ? 1 : -1)
        if rotated > Orientation.Zero.rawValue {
            rotated = Orientation.Zero.rawValue
        } else if rotated < 0 {
            rotated = Orientation.TwoSeventy.rawValue
        }
        return Orientation(rawValue: rotated)!
    }
}

let numShapeTypes: UInt32 = 7

let FirstBlockIdx:Int  = 0
let SecondBlockIdx:Int = 1
let ThirdBlockIdx:Int  = 2
let FourthBlockIdx:Int = 3

class Shape: Hashable, CustomStringConvertible {
    
    let color: BlockColor
    
    var blocks = Array<Block>()
    
    var orientation: Orientation
    
    var column: Int = 0
    var row: Int = 0
    
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }
    
    var bottomBlocks: Array<Block> {
        guard let bottomBlocks = bottomBlocksForOrientations[orientation] else {
            return []
        }
        return bottomBlocks
    }
    
    var hashValue: Int {
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue }
    }
    
    var description: String {
        let firstBlock = "\(blocks[FirstBlockIdx])"
        let secondBlock = "\(blocks[SecondBlockIdx])"
        let thirdBlock = "\(blocks[ThirdBlockIdx])"
        let fourthBlock = "\(blocks[FourthBlockIdx])"
        
        return "\(color) block facing \(orientation): \(firstBlock),\(secondBlock),\(thirdBlock),\(fourthBlock))"
    }
    
    init(column: Int, row: Int, color: BlockColor, orientation: Orientation) {
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        
        initializeBlocks()
    }
    
    convenience init(column: Int, row: Int) {
        self.init(column: column, row: row, color: BlockColor.random(), orientation: Orientation.random())
    }
    
    final func initializeBlocks() {
        guard let blockRowColumnTranslations = blockRowColumnPositions[orientation] else {
            return
        }
        
        blocks = blockRowColumnTranslations.map({ (diff) -> Block in
            return Block(column: column + diff.columnDiff, row: row + diff.rowDiff, color: color)
        })
    }
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
