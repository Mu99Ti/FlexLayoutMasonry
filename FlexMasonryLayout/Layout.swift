//
//  Layout.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/3/23.
//

import Foundation
import UIKit

class MasonryLayout: UICollectionViewLayout {
    
    private let spacing: CGFloat = 10
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
    }
    
    private func reset() {
        layoutAttributes = []
    }
}

extension MasonryLayout {
    struct context {
        var cursor: CGPoint
    }
}
