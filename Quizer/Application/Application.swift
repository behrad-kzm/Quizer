//
//  Application.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform

final class Application {
  static let shared = Application()
  
  private let networkUseCaseProvider: Domain.UseCaseProvider
  
  private init() {
    self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
  }
  
  func configureMainInterface(in window: UIWindow) {
    let navigationController = UINavigationController()
    navigationController.setNavigationBarHidden(true, animated: false)
    let landingNavigator = DefaultLandingPageNavigator(navigationController: navigationController, service: networkUseCaseProvider)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    landingNavigator.toMainPage()
    
  }
}

