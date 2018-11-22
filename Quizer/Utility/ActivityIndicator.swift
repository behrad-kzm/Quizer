import Foundation
import RxSwift
import RxCocoa
import NVActivityIndicatorView

public class ActivityIndicator: SharedSequenceConvertibleType {
  public typealias E = Bool
  public typealias SharingStrategy = DriverSharingStrategy
  
  private let _lock = NSRecursiveLock()
  private let _variable = Variable(false)
  private let _loading: SharedSequence<SharingStrategy, Bool>
  
  private let activityData = ActivityData(size: CGSize(width: 70, height: 70), message: nil, messageFont: nil, messageSpacing: nil, type: .pacman, color: Appearance.colors.yellow(), padding: nil, displayTimeThreshold: nil, minimumDisplayTime: 1, backgroundColor: UIColor(white: 0.6, alpha: 0.85), textColor: nil)
  
  public init() {
    _loading = _variable.asDriver()
      .distinctUntilChanged()
  }
  
  fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.E> {
    return source.asObservable()
      .do(onNext: { _ in
        self.sendStopLoading()
      }, onError: { _ in
        self.sendStopLoading()
      }, onCompleted: {
        self.sendStopLoading()
      }, onSubscribe: subscribed)
  }
  
  private func subscribed() {
    _lock.lock()
    _variable.value = true
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    _lock.unlock()
  }
  
  private func sendStopLoading() {
    _lock.lock()
    _variable.value = false
    NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    _lock.unlock()
  }
  
  public func asSharedSequence() -> SharedSequence<SharingStrategy, E> {
    return _loading
  }
}

extension ObservableConvertibleType {
  public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<E> {
    return activityIndicator.trackActivityOfObservable(self)
  }
}
