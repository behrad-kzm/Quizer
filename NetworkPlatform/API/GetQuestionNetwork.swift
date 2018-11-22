//
//  GetQuestionNetwork.swift
//  NetworkPlatform
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Domain
import RxSwift

public final class GetQuestionNetwork {
  
  private let network: Network<QuestionModel.Response>
  
  init(network: Network<QuestionModel.Response>) {
    self.network = network
  }
  
  public func getQuestion(requestParameter: QuestionModel.Request) -> Observable<QuestionModel.Response> {
    return network.getItem(Constants.EndPoints.questions.rawValue, itemId: String(requestParameter.questionId))
  }
  
}
