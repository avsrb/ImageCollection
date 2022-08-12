//
//  ViewController.swift
//  APM
//
//  Created by Artem Serebriakov on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let idCell = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Image"
        view.backgroundColor = .white
    }
}

/*
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: IndexPath) as! UICollectionView
    }
}
*/

