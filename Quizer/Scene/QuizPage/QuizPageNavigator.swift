//
//  QuizPageNavigator.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit
import Domain
protocol QuizPageNavigator {
  func toNextQuize(quizId: Int)
  func toMainPage()
  func toResult(quizId: Int, answer: AnswerResultType)
}

class DefaultQuizPageNavigator: QuizPageNavigator {
  
  private let navigationController: UINavigationController
  private let services: UseCaseProvider
  
  init(services: UseCaseProvider, navigationController: UINavigationController) {
    self.services = services
    self.navigationController = navigationController
  }
  
  func toResult(quizId: Int, answer: AnswerResultType) {
    let resultVC = AnswerResultViewController(nibName: "AnswerResultViewController", bundle: nil)
    resultVC.viewModel = AnswerResultViewModel(navigator: self, quizId: quizId, status: answer)
    navigationController.pushViewController(resultVC, animated: true)
  }
  
  func toNextQuize(quizId: Int) {
    let quizVC = QuizPageViewController(nibName: "QuizPageViewController", bundle: nil)
    let useCase = services.makeGetQuestionUseCase()
    quizVC.viewModel = QuizePageViewModel(navigator: self, useCase: useCase, quizId: quizId)
    navigationController.pushViewController(quizVC, animated: true)
  }
  
  func toMainPage() {
    navigationController.popToRootViewController(animated: true)
  }
  
}
