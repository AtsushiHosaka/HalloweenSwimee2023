//
//  PictureCollectionViewCell.swift
//  HalloweenSwimee2023
//
//  Created by 保坂篤志 on 2023/10/29.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var obakeImage: UIButton! {
        didSet {
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = CFTimeInterval(Float.random(in: 0.8...1.3))
            animation.repeatCount = Float.infinity
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: obakeImage.center.x, y: obakeImage.center.y - 10))
            animation.toValue = NSValue(cgPoint: CGPoint(x: obakeImage.center.x, y: obakeImage.center.y + 10))
            obakeImage.layer.add(animation, forKey: "position")
            
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.duration = CFTimeInterval(Float.random(in: 0.8...1.3))
            opacityAnimation.autoreverses = true
            opacityAnimation.fromValue = 1.0
            opacityAnimation.toValue = 0.5
            opacityAnimation.repeatCount = Float.infinity
            obakeImage.layer.add(opacityAnimation, forKey: "opacity")
            
            obakeImage.isHidden = false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func delete() {
        
        obakeImage.isHidden = true
    }
}
