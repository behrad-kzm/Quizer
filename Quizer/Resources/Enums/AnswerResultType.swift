//
//  AnswerResultType.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/22/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
enum AnswerResultType {
  case success
  case failur
  case timeOut
  var stringRepresentation: String {
    switch(self) {
    case .success: return "هورااااا! درست انتخاب کردی"
    case .failur: return "وای نه! جوابت اشتباه بود"
    case .timeOut: return "زمان رو ازدست دادی"
    }
  }
}
