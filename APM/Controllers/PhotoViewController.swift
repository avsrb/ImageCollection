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
