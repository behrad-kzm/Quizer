//
//  AnswerResultViewModel.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/22/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
final class AnswerResultViewModel: ViewModelType {
  
  private let navigator: QuizPageNavigator
  private let quizId: Int
  private let disposeBag = DisposeBag()
  let status: AnswerResultType
  init( navigator: QuizPageNavigator, quizId: Int, status: AnswerResultType) {
    self.navigator = navigator
    self.quizId = quizId
    self.status = status
  }
  
  func transform(input: Input) -> Output {
    
    let action = input.newQuizButtonTrigger.do(onNext: { () in
      let nextQuizId = self.quizId + 1
      self.navigator.toNextQuize(quizId: nextQuizId)
    })

    let text = Driver<String>.just(self.status.stringRepresentation)
    return Output(statusText: text, newQuizAction: action)
  }
}

extension AnswerResultViewModel {
  struct Input {
    let newQuizButtonTrigger: Driver<Void>
  }
  
  struct Output {
    let statusText: Driver<String>
    let newQuizAction: Driver<Void>
  }
}

