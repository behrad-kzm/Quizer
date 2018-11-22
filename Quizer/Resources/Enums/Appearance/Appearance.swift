//
//  Appearance.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit

enum Appearance {
  struct colors {
    static let midGray = { return UIColor(rgb: 0x7F7F7F, alpha: 1.0) }
    static let darkGray = { return UIColor(rgb: 0x43425D, alpha: 1.0) }
    static let blue = { return UIColor(rgb: 0x1cd3ff, alpha: 1.0) }
    static let yellow = { return UIColor(rgb: 0xffcc00, alpha: 1.0) }
  }
  
  struct fonts {
    static let buttons = {return UIFont(name: "IRANSansMobile(FaNum)", size: 17)!}
    static let buttonsSelected = {return UIFont(name: "IRANSansMobile(FaNum)", size: 18)!}
    static let captions = {return UIFont(name: "IRANSansMobileFaNum-Light", size: 20)!}
    static let subheads = {return UIFont(name: "IRANSansMobileFaNum-Light", size: 13)!}
  }
}
