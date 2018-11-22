//
//  Vibrator.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/22/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit
struct Vibrator {
  static func vibrate(hardness: Int) {
    if #available(iOS 10.0, *) {
      switch hardness {
      case 1:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
      case 2:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
      case 3:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
      case 4:
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
      case 5:
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
      case 6:
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
      default:
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
      }
    }
  }
}
