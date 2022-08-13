//
//  ViewController.swift
//  APM
//
//  Created by Artem Serebriakov on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
//    private lazy var collectionView : UICollectionView = {
//        let collectionView = UICollectionView()
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    let idCell = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image"
//        view.backgroundColor = .systemBackground
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
//        collectionView.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        return cell
    }
}
