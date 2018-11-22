//
//  QuestionModel.swift
//  Domain
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
public enum QuestionModel: InteractiveModelType {
  
  public struct Request {
    public let questionId: Int
    public init(id: Int) {
      self.questionId = id
    }
  }
  
  public struct Response: Codable {
    public let success: Bool
    public let question: Question
  }
  
}

public struct Question: Codable {
  public let question: String
  public let optionOne: String
  public let optionTwo: String
  public let optionThree: String
  public let optionFour: String
  public let correctOption: String
  public let id: Int
}
