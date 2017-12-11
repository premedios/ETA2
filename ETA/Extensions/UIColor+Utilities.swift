//
//  UIColor+Utilities.swift
//  ETA
//
//  Created by Pedro Remedios on 30/11/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgbColor(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        assert(red >= 0 && red <= 255, "Invalid red component value")
        assert(green >= 0 && green <= 255, "Invalid green component value")
        assert(blue >= 0 && blue <= 255, "Invalid blue component value")
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    static func hexColor(withValue hexColorValue: Int) -> UIColor {
        return UIColor(red: CGFloat(((hexColorValue >> 16) & 0xFF))/255, green: CGFloat(((hexColorValue >> 8) & 0xFF))/255, blue: CGFloat(hexColorValue & 0xFF)/255, alpha: 1)
    }
}
