//
//  UIColor+Extensions.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 20/01/22.
//
import UIKit

extension UIColor {

    public convenience init?(fromHex: Int) {

        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
