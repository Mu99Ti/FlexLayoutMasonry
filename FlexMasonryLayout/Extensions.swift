//
//  Extensions.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/7/23.
//

import Foundation
import UIKit

extension MasonryLayout {
    struct Context {
        var cursor: CGPoint = CGPoint(x: 0, y: 0)
        var maxHeight: CGFloat = 0
        var space: CGFloat = 0
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

    
