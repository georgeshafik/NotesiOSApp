//
//  extension.swift
//  NotesiOSApp
//
//  Created by George Shafik on 30/6/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit


// Extending UIColor - Converting HEX value to RGB
extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
    
    convenience init(rgb: Int) {
        
        // we need to convert the RGB colors to their 255 value.
        self.init(red: (rgb >> 16) & 0xFF,
                  green: (rgb >> 8) & 0xFF,
                  blue: rgb & 0xFF
        )
    }
}

// Added an extensin to UIView
extension UIView {
    
    enum ViewSide {
        case left, right, bottom, top
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
                
        switch side {
        case .left :
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right :
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .bottom :
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.height, height: thickness)
        case .top :
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.height, height: thickness)
        }
        
        layer.addSublayer(border)
    }
}
