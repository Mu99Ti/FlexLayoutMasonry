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
        
        let testView = UIView()
        testView.backgroundColor = .systemYellow
        testView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(testView)

        NSLayoutConstraint.activate([
            testView.topAnchor.constraint(equalTo: view.topAnchor),
            testView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            testView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
    }

}
