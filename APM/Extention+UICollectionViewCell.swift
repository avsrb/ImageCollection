//
//  Extention+UIViewController.swift
//  APM
//
//  Created by Artem Serebriakov on 14.08.2022.
//

import UIKit

fileprivate var aView : UIView?

extension UICollectionViewCell {
    
    func showSpinner() {
        aView = UIView(frame: self.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .medium)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        contentView.addSubview(aView!)
        
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { (t) in
            self.removeSpinner()
        }
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
