//
//  SecondViewController.swift
//  APM
//
//  Created by Artem Serebriakov on 14.08.2022.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: - Private Properties
    private lazy var scrollView = UIScrollView()
    private var cell: CollectionViewCell
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializers
    init(cell: CollectionViewCell) {
        self.cell = cell
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = cell.imageView.image
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        
        scrollView.frame = view.bounds
    
        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
        scrollView.layoutSubviews()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
}

extension PhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }

    func updateMinZoomScaleForSize(_ size: CGSize) {
      let widthScale = size.width / imageView.bounds.width
      let heightScale = size.height / imageView.bounds.height
      let minScale = min(widthScale, heightScale)

      scrollView.minimumZoomScale = minScale
      scrollView.zoomScale = minScale
    }
//    func updateMinZoomScaleForSize(_ size: CGSize) {
//        let widthScale = size.width / imageView.bounds.width
//        let heightScale = imageView.bounds.height
//        let minScale = min(widthScale, heightScale)
//
//        scrollView.minimumZoomScale = minScale
//        scrollView.zoomScale = minScale
//    }
}
