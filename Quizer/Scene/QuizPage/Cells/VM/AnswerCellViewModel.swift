//
//  AnswerCellViewModel.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import Domain
struct AnswerCellViewModel {
  init(option: String) {
    title = option
  }
  let title: String
}
