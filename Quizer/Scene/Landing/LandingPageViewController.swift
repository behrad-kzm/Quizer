//
//  LandingPageViewController.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/20/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit
import RxSwift
class LandingPageViewController: UIViewController {
  //  MARK: - Properties
  @IBOutlet weak var logoLabel: UILabel!
  @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var startQuizButton: UIButton!
  @IBOutlet weak var logoContainer: UIView!
  
  var viewModel: LandingViewModel!
  let disposeBag = DisposeBag()
  //  MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindData()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateLogo()
  }
  
  //  MARK: - Methodes
  func bindData() {
    assert(viewModel != nil)
    let input = LandingViewModel.Input(startTrigger: startQuizButton.rx.tap.asDriver())
    let output = viewModel.transform(input: input)
    output.toQuizAction.drive().disposed(by: disposeBag)
  }
  
  func setupUI() {
    logoContainer.alpha = 0
    startQuizButton.alpha = 0
    startQuizButton.titleLabel?.font = Appearance.fonts.buttons()
  }
  func animateLogo(){
    logoTopConstraint.constant = 100
    Vibrator.vibrate(hardness: 4)
    UIView.animate(withDuration: 1, animations: {
      self.logoContainer.alpha = 1
      self.view.layoutSubviews()
      
    }) {_ in
      Vibrator.vibrate(hardness: 2)
      UIView.animate(withDuration: 0.2, animations: {
        self.startQuizButton.alpha = 1
      }, completion: {_ in
        self.startQuizButton.isUserInteractionEnabled = true
      })
    }
  }
  
}
