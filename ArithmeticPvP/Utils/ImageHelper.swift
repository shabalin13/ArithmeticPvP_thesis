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
    
    func getImageForSkinCell(data: Data, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let svgkImage = SVGKImage(data: data) {
                if let image = svgkImage.uiImage {
                    completion(image)
                } else {
                    completion(nil)
                }
            } else if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
    
}
