//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain

final class NetworkProvider {
  private let apiEndpoint: String
  
  public init() {
    apiEndpoint = Constants.EndPoints.baseUrl.rawValue
  }
  
  public func makeGetQuestionNetwork() -> GetQuestionNetwork {
    let network = Network<QuestionModel.Response>(apiEndpoint)
    return GetQuestionNetwork(network: network)
  }
  
}
