//
//  CollectionViewCell.swift
//  APM
//
//  Created by Artem Serebriakov on 13.08.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    weak var delegate: ViewController?
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var imageURL: URL? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
    
    //Задача разработчика состоит только в выборе очереди и добавлении задания (как правило, замыкания) в эту очередь синхронно с помощью функции sync или асинхронно с помощью функции async, дальше работает исключительно iOS.

    private func updateUI() {
        guard let imageURL = imageURL else { return }
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    //QOS_CLASS_UTILITY - используется для задач, в которых не требуется получить немедленный результат, например запрос в сеть. Наиболее сбалансированный QOS с точки зрения потребления ресурсов.
    
    // из лекции эплла подготовка изображений, чтобы они не тупили при скроле
    //if let image = UIImage(data: pathToImage) {
    //    Task {
    //        let prepareImage = await image.byPreparingForDisplay()
    
    //        imageView.image = prepareImage
    //    }
    //}
}
