//
//  LandingPageNavigator.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit
import Domain

protocol LandingPageNavigator {
  func toQuize()
  func toMainPage()
}

class DefaultLandingPageNavigator: LandingPageNavigator {
  
  private let navigationController: UINavigationController
  private let services: UseCaseProvider
  
  init(navigationController: UINavigationController, service: UseCaseProvider) {
    self.navigationController = navigationController
    self.services = service
  }
  
  func toQuize() {
    let quizVC = QuizPageViewController(nibName: "QuizPageViewController", bundle: nil)
    let useCase = services.makeGetQuestionUseCase()
    let navigator = DefaultQuizPageNavigator(services: services, navigationController: navigationController)
    quizVC.viewModel = QuizePageViewModel(navigator: navigator, useCase: useCase, quizId: 1)
    navigationController.pushViewController(quizVC, animated: true)
  }
  
  func toMainPage() {
    
    let landingVC = LandingPageViewController(nibName: "LandingPageViewController", bundle: nil)
    landingVC.viewModel = LandingViewModel(navigator: self)
    navigationController.pushViewController(landingVC, animated: true)
    
  }
  
}
