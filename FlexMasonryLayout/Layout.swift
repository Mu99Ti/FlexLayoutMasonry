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
        
        for item in 0...10 {
            
            let cellWidth = collectionView.frame.width / 5
            let cellWidthFactor  = randomFrame().x * cellWidth
            let cellHeightFactor = randomFrame().y * cellWidth
            let indexPath = IndexPath(item: item, section: 0)
            let collectionViewWidth: CGFloat = collectionView.frame.width
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            
            if item == 0 {
                context.space = collectionViewWidth
                statsPrinter(status: true, item: item, maxHeight: context.maxHeight, point: context.cursor, size: .init(width: cellWidthFactor, height: cellHeightFactor), space: context.space)
                
                let frame = createFrame(location: context.cursor, width: cellWidthFactor, height: cellHeightFactor)
                attributes.frame = frame
                layoutAttributes.append(attributes)
                context.cursor.x = frame.width + lineSpacing
                context.maxHeight = cellHeightFactor
                context.space = collectionViewWidth - cellWidthFactor + lineSpacing
                
                statsPrinter(status: false, item: item, maxHeight: context.maxHeight, point: context.cursor, size: .init(width: cellWidthFactor, height: cellHeightFactor), space: context.space)
            } else {
                if context.space >= cellWidthFactor {
                    statsPrinter(status: true, item: item, maxHeight: context.maxHeight, point: context.cursor, size: .init(width: cellWidthFactor, height: cellHeightFactor), space: context.space)
                    
                    let frame = createFrame(location: context.cursor, width: cellWidthFactor, height: cellHeightFactor)
                    attributes.frame = frame
                    layoutAttributes.append(attributes)
                    context.cursor.x += frame.width
                    context.maxHeight = cellHeightFactor
                    context.space = context.space - frame.width + lineSpacing
                    
                    statsPrinter(status: false, item: item, maxHeight: context.maxHeight, point: context.cursor, size: .init(width: cellWidthFactor, height: cellHeightFactor), space: context.space)
                } else {
                    context.space = collectionViewWidth
                    debugPrint("max height is: \(context.maxHeight) and y point is: \(context.cursor.y)")
                    context.cursor.y = max(context.maxHeight, cellHeightFactor)
                    context.cursor.x = 0
                    debugPrint("max height is: \(context.maxHeight) and y point is: \(context.cursor.y)")
                    statsPrinter(status: true, item: item, maxHeight: context.maxHeight, point: context.cursor, size: .init(width: cellWidthFactor, height: cellHeightFactor), space: context.space)
                    
                    let frame = createFrame(location: context.cursor, width: cellWidthFactor, height: cellHeightFactor)
                    attributes.frame = frame
                    layoutAttributes.append(attributes)
                    context.cursor.x += cellWidthFactor + lineSpacing
                    context.maxHeight = cellHeightFactor
                    context.space = context.space - frame.width + lineSpacing
                    
                    statsPrinter(status: false, item: item, maxHeight: context.maxHeight, point: context.cursor, size: .init(width: cellWidthFactor, height: cellHeightFactor), space: context.space)
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
    
    private func statsPrinter(status: Bool,item: Int, maxHeight: CGFloat, point: CGPoint, size: CGSize, space: CGFloat) {
        if status {
            debugPrint("item number: \(item) and white space is: \(space)")
            debugPrint("item number: \(item) and cell width is: \(size.width)")
            debugPrint("item number: \(item) and x point is: \(point.x)")
            debugPrint("item number: \(item) and y point is: \(point.y)")
            debugPrint("item number: \(item) and max height is: \(maxHeight)")
            debugPrint("item number: \(item) and cell height is: \(size.height)")
        } else {
            debugPrint("item number: \(item) and after frame white space is: \(space)")
            debugPrint("item number: \(item) and after frame cell width is: \(size.width)")
            debugPrint("item number: \(item) and after frame x point is: \(point.x)")
            debugPrint("item number: \(item) and after frame y point is: \(point.y)")
            debugPrint("item number: \(item) and after frame max height is: \(maxHeight)")
            debugPrint("item number: \(item) and after frame cell height is: \(size.height)")
        }
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
