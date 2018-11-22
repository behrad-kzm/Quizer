//
//  Network.swift
//  NetworkPlatform
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import Foundation
import Alamofire
import Domain
import RxAlamofire
import RxSwift

final class Network<T: Codable> {
  
  private let endPoint: String
  private let scheduler: ConcurrentDispatchQueueScheduler
  
  init(_ endPoint: String) {
    self.endPoint = endPoint
    self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
  }
  
  func getItem(_ path: String, itemId: String) -> Observable<T> {
    let absolutePath = itemId == "" ? "\(endPoint)/\(path)" : "\(endPoint)/\(path)/\(itemId)"
    
    return RxAlamofire
      .request(.get, absolutePath, headers: [:])
      .debug()
      .observeOn(scheduler)
      .responseData()
      .map({ (json) -> T in
        let data = json.1
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: data)
      })
      .retry(1)
      .retryWhen({ (errorObservable: Observable<Error>) in
        
        errorObservable.flatMap({ (error) -> Single<String> in
          
          throw error
        })
      })
    
  }
  
}
