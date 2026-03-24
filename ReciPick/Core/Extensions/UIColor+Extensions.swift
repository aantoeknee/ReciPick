//
//  UIColor+Extensions.swift
//  ReciPick
//
//  Created by Anthony Tan on 3/22/26.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = CGFloat((int >> 16) & 0xFF) / 255
        let g = CGFloat((int >> 8) & 0xFF) / 255
        let b = CGFloat(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
