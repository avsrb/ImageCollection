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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = nil
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.color = .black
        ai.hidesWhenStopped = true
        return ai
    }()
    
    var imageURL: URL? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundView = imageView
        self.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
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
        imageView.image = nil
    }
    
    //Задача разработчика состоит только в выборе очереди и добавлении задания (как правило, замыкания) в эту очередь синхронно с помощью функции sync или асинхронно с помощью функции async, дальше работает исключительно iOS.

    private func updateUI() {
        guard let imageURL = imageURL else { return }
        activityIndicator.startAnimating()
//        self.showSpinner()
        
        DispatchQueue.global(qos: .utility).async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    self.activityIndicator.stopAnimating()
                    //self.removeFromSuperview()
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Cannot acces to \(imageURL)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.delegate?.present(alert, animated: false)
                    self.activityIndicator.stopAnimating()
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

extension ViewController {
    func showAlert(title: String, message: String, firstAction: String, secondAction: String?) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: firstAction, style: UIAlertAction.Style.default, handler: nil))
        if let secondAction = secondAction {
            alert.addAction(UIAlertAction(title: secondAction, style: UIAlertAction.Style.cancel, handler: nil))
        }
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
