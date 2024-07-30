//
//  Extension_Color.swift
//  AR Floor Tile
//
//  Created by พัทธนันท์ ปุ่นน้ำใส on 12/8/20.
//  Copyright © 2020 พัทธนันท์ ปุ่นน้ำใส. All rights reserved.
//

import UIKit

// Extention UIColor
extension UIColor{
    
    static func whiteAlpha(alpha : CGFloat) -> UIColor{
        return UIColor(white: 1, alpha: alpha)
    }
    
    static func BlackAlpha(alpha : CGFloat) -> UIColor{
        return UIColor(white: 0, alpha: alpha)
    }
    
    static func rgb(red : CGFloat, green : CGFloat, blue : CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func rgbAlpha(red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    public class var random: UIColor {
        return UIColor(red: CGFloat(drand48()),
                       green: CGFloat(drand48()),
                       blue: CGFloat(drand48()), alpha: 1.0)
    }
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
    
    // List Color
    // Primary Color
    static var PrimaryColor = UIColor(hex: "#F9F4EDFF")
    // Secondary Color
    static var SecondaryColor = UIColor(hex: "#BEE3DBFF")
    // Accent Color
    static var AccentColor = UIColor(hex: "#89B0AEFF")
    // Nautral1 (White)
    static var NautralWhite = UIColor(hex: "#FAF9F9FF")
    // Nautral2 (Black)
    static var NautralBlack = UIColor(hex: "#707070FF")
    // Success Color
    static var SuccessColor = UIColor(hex: "#52B788FF")
    // Error Color
    static var ErrorColor = UIColor(hex: "#EE6C4DFF")
    // FaceBook Color
    static var FacebookColor = UIColor(hex: "#008CBBFF")
    //Line Color
    static var LineColor = UIColor(hex: "#13B81AFF")

}
