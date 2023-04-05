//
//  ViewController.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemYellow
        let masonryLayout = UICollectionViewFlowLayout()
        let collectionView = MasonryCollectionView(frame: .zero, collectionViewLayout: MasonryLayout())
        masonryLayout.scrollDirection = .vertical
        view.backgroundColor = .systemYellow
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


