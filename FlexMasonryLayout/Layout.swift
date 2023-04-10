//
//  Layout.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/3/23.
//

import Foundation
import UIKit

class MasonryLayout: UICollectionViewLayout {
    

    private var context = Context()
    private let spacing: CGFloat = 10
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentSize: CGSize = .zero
    private var contentHeight: CGFloat = 0
    private let lineSpacing: CGFloat = 0
    private var sumCellWidth: CGFloat = 0.0
    private let cellTypes = CellModel.CellType.allCases
    private var cellRowsArray: [CGRect] = []
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        reset()
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        
        context.cursor.x = lineSpacing
        
        for item in 0...numberOfItems {
            
            let cellWidthOrigin = collectionView.frame.width / 5
            let cellWidth  = randomFrame().x * cellWidthOrigin
            let cellHeight = randomFrame().y * cellWidthOrigin
            let indexPath = IndexPath(item: item, section: 0)
            let collectionViewWidth: CGFloat = collectionView.frame.width
            let cellLayoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            
            if item == 0 {
                context.space = collectionViewWidth
                
                let frame = createFrame(location: context.cursor, width: cellWidth, height: cellHeight)
                cellLayoutAttribute.frame = frame
                cellRowsArray.append(frame)
                layoutAttributes.append(cellLayoutAttribute)
                context.cursor.x = frame.width + lineSpacing
                
                context.maxHeight = cellHeight
                context.space = collectionViewWidth - cellWidth - lineSpacing
                
            } else {
                
                if context.space >= cellWidth {
                    
                    let frame = createFrame(location: context.cursor, width: cellWidth, height: cellHeight)
                    cellLayoutAttribute.frame = frame
                    cellRowsArray.append(frame)
                    layoutAttributes.append(cellLayoutAttribute)
                    context.cursor.x += frame.width
                    context.maxHeight = layoutAttributes.sorted(by: { $0.frame.maxY > $1.frame.maxY }).first?.frame.maxY ?? 0.0
                    context.space = context.space - frame.width - lineSpacing
                } else {
                    context.space = collectionViewWidth
                    context.cursor.y = context.maxHeight
                    context.cursor.x = 0

                    
                    let frame = createFrame(location: context.cursor, width: cellWidth, height: cellHeight)
                    cellLayoutAttribute.frame = frame
                    cellRowsArray.append(frame)
                    layoutAttributes.append(cellLayoutAttribute)
                    context.cursor.x += cellWidth + lineSpacing
                    context.maxHeight = cellHeight
                    context.space = context.space - frame.width - lineSpacing
                    context.maxHeight = layoutAttributes.sorted(by: { $0.frame.maxY > $1.frame.maxY }).first?.frame.maxY ?? 0.0
                }
            }
        }
        
        contentSize = CGSize(width: collectionView.bounds.width, height: context.cursor.y + context.maxHeight)
    }
    
    private func randomFrame() -> CGPoint {
        let x = CGFloat.random(in: 1...5)
        let y = CGFloat.random(in: 1...5)
        return .init(x: x, y: y)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        layoutAttributes.filter { $0.frame.intersects(rect)}
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        layoutAttributes[indexPath.item]
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    private func reset() {
        layoutAttributes = []
        context.cursor = CGPoint(x: 0, y: 0)
        context.maxHeight = 0
        context.space = 0
    }
    
    private func whiteSpaceCalculator(collectionViewWidth: CGFloat, cursorLocationX: CGFloat, latestCellWidth: CGFloat) -> CGFloat{
        return collectionViewWidth - (cursorLocationX + latestCellWidth)
    }
    
    private func canCellFit(collectionViewWidth: CGFloat, cursorLocationX: CGFloat, latestCellWidth: CGFloat) -> Bool {
        if collectionViewWidth >= cursorLocationX + latestCellWidth {
            return true
        }
        return false
    }
    
    private func createFrame(location: CGPoint, width: CGFloat, height: CGFloat) -> CGRect {
        return .init(x: location.x, y: location.y, width: width, height: height)
    }
}

//extension MasonryLayout {
//    struct Context {
//        var cursor: CGPoint = CGPoint(x: 0, y: 0)
//        var maxHeight: CGFloat = 0
//        var space: CGFloat = 0
//    }
//}
//var cellFit: Bool = canCellFit(collectionViewWidth: collectionViewWidth, cursorLocationX: xPoint, latestCellWidth: cellWidthFactor)
//
//
//whiteSpace += whiteSpaceCalculator(collectionViewWidth: collectionViewWidth, cursorLocationX: xPoint, latestCellWidth: cellWidthFactor)
//
//if whiteSpace >= cellWidthFactor {
//    let frame = createFrame(location: context.cursor, width: cellWidthFactor, height: cellHeightFactor)
//    cellAttributes[item] = frame
//    attributes.frame = frame
//    layoutAttributes.append(attributes)
//    xPoint += cellWidthFactor + lineSpacing
//    context.maxHeight = max(context.maxHeight, cellHeightFactor)
//    whiteSpace += whiteSpaceCalculator(collectionViewWidth: collectionViewWidth, cursorLocationX: xPoint, latestCellWidth: cellWidthFactor)
//}else {
//    whiteSpace = collectionViewWidth
//    xPoint += lineSpacing
//    context.cursor.y += context.maxHeight + lineSpacing
//    debugPrint("cursor location is: \(context.cursor)")
//    context.maxHeight = 0
//    let frame = createFrame(location: context.cursor, width: cellWidthFactor, height: cellHeightFactor)
//    cellAttributes[item] = frame
//    attributes.frame = frame
//    layoutAttributes.append(attributes)
//    whiteSpace += whiteSpaceCalculator(collectionViewWidth: collectionViewWidth, cursorLocationX: xPoint, latestCellWidth: cellWidthFactor)
//}
//
////            if context.cursor.x >= collectionView.frame.width {
////                context.cursor.x = lineSpacing
////                context.cursor.y += context.maxHeight + lineSpacing
////                context.maxHeight = 0
////            }
