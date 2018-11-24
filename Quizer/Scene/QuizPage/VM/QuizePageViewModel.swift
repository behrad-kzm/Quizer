//
//  QuizePageViewModel.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

final class QuizePageViewModel: ViewModelType {
  
  private let navigator: QuizPageNavigator
  private let useCase: Domain.GetQuestionUseCase
  private let quizId: Int
  private let disposeBag = DisposeBag()
  
  let countDownTime = 30
  init( navigator: QuizPageNavigator, useCase: Domain.GetQuestionUseCase, quizId: Int) {
    self.navigator = navigator
    self.useCase = useCase
    self.quizId = quizId
  }
  
  func transform(input: Input) -> Output {
    let activityIndicator = ActivityIndicator()
    let errorTracker = ErrorTracker()
    let pageResponseTuple = input.viewWillAppearTrigger.flatMapLatest {_ -> Driver<([AnswerCellViewModel],String,String,Int)> in
      let result = self.useCase.getQuestion(requestParameter: QuestionModel.Request(id: self.quizId)).trackActivity(activityIndicator).trackError(errorTracker).map({ (response) -> ([AnswerCellViewModel],String,String,Int) in
        let question = response.question.question
        let answers = [response.question.optionOne, response.question.optionTwo, response.question.optionThree, response.question.optionFour].compactMap({ (option) -> AnswerCellViewModel in
          return AnswerCellViewModel(option: option)
        })
        
        let questionNumber = "سؤال" + "\(self.quizId)"
        let correctIndex = (Int(response.question.correctOption) ?? 0 ) - 1
        return (answers, question, questionNumber,correctIndex)
      })
      return result.asDriverOnErrorJustComplete()
    }
    
    let isCorrectSelected = input.selectedIndexPath.withLatestFrom(pageResponseTuple.map{$0.3}) { (selectedIndex, correctIndex) in
      return selectedIndex.row == correctIndex
    }
    
    let timer = pageResponseTuple.flatMapLatest { _ -> Driver<Int> in
      let countDownTimer =  TimerCreator.count(from: self.countDownTime, to: 0, quickStart: true).asDriverOnErrorJustComplete()
      return countDownTimer
    }
    let isTimesUp = timer.map { (current) -> Bool in
      if current < 6 {
        Vibrator.vibrate(hardness: 3)
      }
      return current < 1
    }
    let timeOutAction = isTimesUp.map { (finished) -> Void in
      if finished {
        self.navigator.toResult(quizId: self.quizId, answer: .timeOut)
      }
    }
    let timerCurrentText = timer.map { (current) -> String in
      return String(format: "%02d", current)
    }
    let timerProgress = timer.map { (current) -> Double in
      let difference = (self.countDownTime - current)
      return Double(difference) / Double(self.countDownTime)
    }
    let action = isCorrectSelected.do(onNext: { (correction) in
        self.navigator.toResult(quizId: self.quizId, answer: correction ? .success : .failur)
    }).mapToVoid()

    let fetching = activityIndicator.asDriver()
    let errors = errorTracker.asDriver()
    return Output(answeringAction: action, timeOutAction: timeOutAction, answers: pageResponseTuple.map{$0.0}, questionNumber: pageResponseTuple.map{$0.2}, timerLabel: timerCurrentText, timer: timer, timerProgress: timerProgress, questionText: pageResponseTuple.map{$0.1}, didSelectedCorrectAnswer: isCorrectSelected, error: errors , isFetching: fetching)
  }
}

extension QuizePageViewModel {
  struct Input {
    let viewWillAppearTrigger: Driver<Void>
    let selectedIndexPath: Driver<IndexPath>
  }
  
  struct Output {
    let answeringAction: Driver<Void>
    let timeOutAction: Driver<Void>
    let answers: Driver<[AnswerCellViewModel]>
    let questionNumber: Driver<String>
    let timerLabel: Driver<String>
    let timer: Driver<Int>
    let timerProgress: Driver<Double>
    let questionText: Driver<String>
    let didSelectedCorrectAnswer: Driver<Bool>
    let error: Driver<Error>
    let isFetching: Driver<Bool>
  }
}

