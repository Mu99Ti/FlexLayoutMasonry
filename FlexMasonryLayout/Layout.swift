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
    private let lineSpacing: CGFloat = 10
    private let cellTypes = CellModel.CellType.allCases
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        super.prepare()
        
//        guard let randomCell = cellTypes.randomElement() else { return }
        guard let collectionView = collectionView else { return }
        
        reset()
        
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        var cellAttributes: [Int:CGRect] = [:]
        
        context.cursor.x = lineSpacing
        
        for item in 0...numberOfItems {
            
            let cellWidth = collectionView.frame.width / 5
            let cellWidthFactor  = randomFrame().x * cellWidth
            let cellHeightFactor = randomFrame().y * cellWidth
            var sumCellWidth: CGFloat = 0.0
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let frame = CGRect(x: context.cursor.x,
                               y: context.cursor.y,
                               width: cellWidthFactor,
                               height: cellHeightFactor)
            cellAttributes[item] = CGRect(x: context.cursor.x, y: context.cursor.y, width: cellWidthFactor, height: cellHeightFactor)
            attributes.frame = frame
            layoutAttributes.append(attributes)
            
            context.cursor.x += cellWidthFactor + lineSpacing
            context.maxHeight = max(context.maxHeight, cellHeightFactor)
            
            if (context.cursor.x + (cellAttributes[item]!.width)) >= collectionView.frame.width {
                context.cursor.x = lineSpacing
                context.cursor.y += context.maxHeight + lineSpacing
                context.maxHeight = 0
            }
        
            
            debugPrint("sum of cell width is: \(sumCellWidth)")
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
    }
}

extension MasonryLayout {
    struct Context {
        var cursor: CGPoint = CGPoint(x: 0, y: 0)
        var maxHeight: CGFloat = 0
    }
}
