//
//  Cell.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/3/23.
//

import Foundation
import UIKit

class Cell: UICollectionViewCell {
    
    private let cellModel = CellModel(cellType: CellModel.CellType.allCases.randomElement() ?? .small)
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel(frame: .zero)
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Arial", size: 20)
        textLabel.textColor = .black
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            textLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var reuseIdentifier: String {
        String.init(describing: Self.self)
    }
    
    func configure (cellText: String, cellColor: UIColor) {
        textLabel.text = cellText
        self.backgroundColor = cellColor
    }
}
