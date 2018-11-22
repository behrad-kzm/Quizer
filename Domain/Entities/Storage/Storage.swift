//
//  Storage.swift
//  Domain
//
//  Created by Behrad Kazemi on 11/22/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
  public enum Storage {
    public enum UserScore {
      public static func getUserScore() -> Int {
        let score = UserDefaults.standard.integer(forKey: Constants.StorageKeys.userScore.rawValue)
        return score
      }
      
      public static func setUserScore(score: Int) {
        UserDefaults.standard.set(score, forKey: Constants.StorageKeys.userScore.rawValue)
      }
    }
    public enum PostInfo: InteractiveModelType {
      public struct Request: Codable {
        public let projectId: Int
        public init(projectId: Int) {
          self.projectId = projectId
        }
      }
      public struct Response: Codable {}
    }
  }
