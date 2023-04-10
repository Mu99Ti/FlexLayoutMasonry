//
//  ViewController.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: MasonryCollectionView?
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemYellow
        let masonryLayout = UICollectionViewFlowLayout()
        collectionView = MasonryCollectionView(frame: .zero, collectionViewLayout: MasonryLayout())
        masonryLayout.scrollDirection = .vertical
        view.backgroundColor = .systemYellow
        view.addSubview(collectionView!)
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


