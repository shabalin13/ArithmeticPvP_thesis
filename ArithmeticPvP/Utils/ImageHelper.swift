//
//  ImageHelper.swift
//  ArithmeticPvP
//
//  Created by DIMbI4 on 29.04.2023.
//

import Foundation
import UIKit
import SVGKit

class ImageHelper {
    
    static var shared = ImageHelper()
    
    func getImage(data: Data) -> UIImage? {
        
        if let image = UIImage(data: data) {
            return image
        } else if let svgkImage = SVGKImage(data: data) {
            if let image = svgkImage.uiImage {
                return image
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
}
