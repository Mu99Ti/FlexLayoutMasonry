//
//  ViewController.swift
//  FlexMasonryLayout
//
//  Created by Muhamad Talebi on 4/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let cellModel: CellModel?
    lazy var collectioView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: MasonryLayout())
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectioView)
        NSLayoutConstraint.activate([
            collectioView.topAnchor.constraint(equalTo: view.topAnchor),
            collectioView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectioView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectioView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDelegate {}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        cell.configure(cellText: <#T##String#>, cellColor: <#T##UIColor#>)
        
    }
}
