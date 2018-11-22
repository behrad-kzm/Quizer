//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
public protocol UseCaseProvider {
  func makeGetQuestionUseCase() -> GetQuestionUseCase
}
