//
//  Block.swift
//  iTetris
//
//  Created by Bruno Da luz on 16/04/16.
//  Copyright © 2016 Bruno v0id. All rights reserved.
//

import SpriteKit

let numberOfColors: UInt32 = 6

enum BlockColor: Int, CustomStringConvertible {
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    var sprintName: String {
        switch self {
        case .Blue:
            return "blue"
        
        case .Orange:
            return "orange"
            
        case .Purple:
            return "purple"
            
        case .Red:
            return "red"
            
        case .Teal:
            return "teal"
            
        case .Yellow:
            return "yellow"
        }
    }
    
    var description: String {
        return self.sprintName
    }
    
    static func random() -> BlockColor {
        return BlockColor(rawValue: Int(arc4random_uniform(numberOfColors)))!
    }
}

class Block: NSHashTable {
    // constants
    let color: BlockColor
    
    // properties
    var column: Int
    var row: Int
    var sprite: SKShapeNode?
    
    var sprintName: String {
        return color.sprintName
    }
    
    override var hashValue: Int {
        return self.column ^ self.row
    }
    
    override var description: String {
        return "\(color) : [\(column),\(row)]"
    }
    
    init(column: Int, row: Int, color: BlockColor) {
        self.column = column
        self.row = row
        self.color = color
        
        super.init(coder: NSCoder())!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.row && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}