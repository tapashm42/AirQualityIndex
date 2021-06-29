//
//  UIColor+Extenstion.swift
//  AirQualityIndex
//
//  Created by Mollick, Tapash on 26/06/21.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    struct AQIColor {
        static let lightGreen = UIColor.init(red: 150, green: 190, blue: 59)
        static let darkRed = UIColor.init(red: 154, green: 26, blue: 26)
    }
    
}
