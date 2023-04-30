//
//  UIViewExtension.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 24.04.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func setBackgroundImage() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Design.shared.backgroundImage
        imageView.center = self.center
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
    }
    
}
