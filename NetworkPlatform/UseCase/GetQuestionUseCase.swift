//
//  GetQuestionUseCase.swift
//  NetworkPlatform
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import RxSwift
import Domain

public final class GetQuestionUseCase: Domain.GetQuestionUseCase {  
  private let network: GetQuestionNetwork
  
  init(network: GetQuestionNetwork) {
    self.network = network
  }
  
  public func getQuestion(requestParameter: QuestionModel.Request) -> Observable<QuestionModel.Response> {
    return network.getQuestion(requestParameter:requestParameter)
  }
  
}
