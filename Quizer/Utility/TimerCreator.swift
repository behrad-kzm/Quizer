//
//  TimerCreator.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import RxSwift

struct TimerCreator {
  static func count(from: Int, to: Int, quickStart: Bool) -> Observable<Int> {
    return Observable<Int>
      .timer(quickStart ? 0 : 1, period: 1, scheduler: MainScheduler.instance)
      .take(from - to + 1)
      .map { from - $0 }
  }
}

