//
//  CollectionView.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/3/23.
//

import Foundation
import UIKit

class MasonryCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        backgroundColor = .white
        dataSource = self
        delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension MasonryCollectionView: UICollectionViewDelegate {}
extension MasonryCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellTypes = CellModel.CellType.allCases
        let randomCells = cellTypes.randomElement()!
        let cellModel = CellModel(cellType: randomCells)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier,
                                                      for: indexPath) as! Cell
        cell.configure(cellText: "\(indexPath.item + 1)", cellColor: cellModel.cellColor)

        
        return cell
    }
}


