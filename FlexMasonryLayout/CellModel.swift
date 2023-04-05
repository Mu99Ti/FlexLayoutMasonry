//
//  CellModel.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/3/23.
//

import Foundation
import UIKit

class CellModel {
    
    private var cellType: CellType
    var cellSize: CGPoint
    var cellColor: UIColor
    
    init(cellType: CellType) {
        self.cellType = cellType
        switch cellType {
        case .small:
            cellSize = CGPoint(x: 1, y: 2)
            cellColor = UIColor(cgColor: CGColor(red: 255/255,
                                                 green:0/255,
                                                 blue: 0/255,
                                                 alpha: 1))
        case .medium:
            cellSize = CGPoint(x: 1, y: 3)
            cellColor = UIColor(cgColor: CGColor(red: 50/255,
                                green: 0/255,
                                blue: 255/255,
                                alpha: 1))
        case .large:
            cellSize = CGPoint(x: 2, y: 4)
            cellColor = UIColor(cgColor: CGColor(red: 50/255,
                                green: 50/255,
                                blue: (CGFloat.random(in: 0...255))/255,
                                alpha: 1))
        case .extraLarge:
            cellSize = CGPoint(x: 2, y: 5)
            cellColor = UIColor(cgColor: CGColor(red: (CGFloat.random(in: 0...255))/255,
                                green: 50/255,
                                blue: (CGFloat.random(in: 0...255))/255,
                                alpha: 1))
        case .doubleExtraLarge:
            cellSize = CGPoint(x: 3, y: 4)
            cellColor = UIColor(cgColor: CGColor(red: 50/255,
                                green: (CGFloat.random(in: 0...255))/255,
                                blue: (CGFloat.random(in: 0...255))/255,
                                alpha: 1))
        }
    }
}

extension CellModel {
    enum CellType: CaseIterable {
        case small
        case medium
        case large
        case extraLarge
        case doubleExtraLarge
    }
}
