//
//  UIColor+Hex.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit
public extension UIColor {
  convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    assert(alpha >= 0 && alpha <= 1.0, "Invalid alpha component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
  }
  
  convenience init(rgb: Int, alpha: CGFloat) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF,
      alpha: alpha
    )
  }
}
