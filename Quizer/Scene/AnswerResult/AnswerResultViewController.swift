//
//  AnswerResultViewController.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit
import Lottie
import RxSwift
class AnswerResultViewController: UIViewController {
  @IBOutlet weak var nextQuizButton: UIButton!
  @IBOutlet weak var animationViewContriner: UIView!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var shiningImageView: UIImageView!
  @IBOutlet weak var glowingViewBottomConstraint: NSLayoutConstraint!
  var animationView: LOTAnimationView!
  var viewModel: AnswerResultViewModel!
  let disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animationView.play()
    if viewModel.status == .success {
      glowingAnimation()
    }
  }
  
  func setupUI(){
    assert(viewModel != nil)
    shiningImageView.alpha = 0
    animationViewContriner.layer.cornerRadius = animationViewContriner.bounds.height / 2
    let animationName: String
    switch viewModel.status {
    case .success:
      Vibrator.vibrate(hardness: 2)
      animationName = "win"
    case .failur:
      Vibrator.vibrate(hardness: 1)
      animationName = "loose"
    default:
      Vibrator.vibrate(hardness: 3)
      animationName = "stopwatch"
    }
    statusLabel.font = Appearance.fonts.captions()
    nextQuizButton.titleLabel?.font = Appearance.fonts.buttons()
    animationView = LOTAnimationView(name: animationName)
    animationViewContriner.addSubview(animationView)
    animationViewContriner.layoutSubviews()
    animationView.contentMode = .scaleAspectFit
    animationView.frame = animationViewContriner.bounds
  }
  
  func glowingAnimation(){
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotateAnimation.fromValue = 0.0
    rotateAnimation.toValue = CGFloat(Double.pi * 2)
    rotateAnimation.isRemovedOnCompletion = false
    rotateAnimation.duration = 60
    rotateAnimation.repeatCount=Float.infinity
    shiningImageView.layer.add(rotateAnimation, forKey: nil)
    UIView.animate(withDuration: 0.2, animations: {
      self.shiningImageView.alpha = 1
      self.glowingViewBottomConstraint.constant = -50
      self.view.layoutSubviews()
    })
  }

  func bindData(){
    let input = AnswerResultViewModel.Input(newQuizButtonTrigger: nextQuizButton.rx.tap.asDriver())
    
    let output = viewModel.transform(input: input)
    output.statusText.drive(statusLabel.rx.text).disposed(by: disposeBag)
    output.newQuizAction.drive().disposed(by: disposeBag)
  }
}
