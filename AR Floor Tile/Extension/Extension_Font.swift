//
//  Extension_Font.swift
//  AR Floor Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 12/8/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

extension UIFont{
        
    // FredokaOne Regular
    static func FredokaOneRegular(size : CGFloat) -> UIFont{
        return UIFont(name: "FredokaOne-Regular", size: size)!
    }
    
    // Lato Light
    static func LatoLight(size : CGFloat) -> UIFont{
        return UIFont(name: "Lato-Light", size: size)!
    }
    
    // Lato Italic
    static func LatoItalic(size : CGFloat) -> UIFont{
        return UIFont(name: "Lato-Italic", size: size)!
    }

    // Header1 (H1)
    static var H1 = UIFont(name: "FredokaOne-Regular", size: 36)
    // Header2 (H2)
    static var H2 = UIFont(name: "FredokaOne-Regular", size: 28)
    // Header3 (H3)
    static var H3 = UIFont(name: "FredokaOne-Regular", size: 20)
    
    // Subtitle1
    static var Subtitle1 = UIFont(name: "FredokaOne-Regular", size: 16)
    // Subtitle2
    static var Subtitle2 = UIFont(name: "FredokaOne-Regular", size: 14)
    
    // Body1
    static var Body1 = UIFont(name: "Lato-Light", size: 16)
    // Body2
    static var Body2 = UIFont(name: "Lato-Light", size: 14)
    
    // Button1
    static var Button1 = UIFont(name: "FredokaOne-Regular", size: 20)
    // Button2
    static var Button2 = UIFont(name: "FredokaOne-Regular", size: 14)
    
}

extension String {
    // formatting text for currency textField
    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            //formatter.currencySymbol = "฿"
            formatter.maximumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
