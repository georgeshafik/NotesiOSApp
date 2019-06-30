//
//  extension.swift
//  NotesiOSApp
//
//  Created by George Shafik on 30/6/19.
//  Copyright © 2019 George Shafik. All rights reserved.
//

import UIKit


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
