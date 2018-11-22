//
//  AppDelegate.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupApplication()
    return true
  }
  private func setupApplication() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    Application.shared.configureMainInterface(in: window)
    self.window = window
  }
}

