//
//  Array2D.swift
//  iTetris
//
//  Created by Bruno Da luz on 16/04/16.
//  Copyright © 2016 Bruno v0id. All rights reserved.
//

class Array2D<T> {
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(count: rows * columns, repeatedValue: nil)
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            return array[(row * columns) + column]
        }
        set {
           array[(row * columns) + column] = newValue
        }
    }
    
}