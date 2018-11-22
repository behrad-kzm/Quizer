//
//  LandingViewModel.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import RxSwift
import RxCocoa
import Domain

final class LandingViewModel: ViewModelType {
  private let navigator: LandingPageNavigator
  
  init( navigator: LandingPageNavigator) {
    self.navigator = navigator
  }
  
  func transform(input: Input) -> Output {
    let action = input.startTrigger.do(onNext: { () in
      self.navigator.toQuize()
    })
    return Output(toQuizAction: action)
  }
}

extension LandingViewModel {
  struct Input {
    let startTrigger: Driver<Void>
  }
  
  struct Output {
    let toQuizAction: Driver<Void>
  }
}
