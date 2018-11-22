//
//  QuizPageViewController.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import KDCircularProgress

class QuizPageViewController: UIViewController {
  @IBOutlet weak var questionNumberLabel: UILabel!
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var progressView: KDCircularProgress!
  @IBOutlet weak var answersTableView: UITableView!
  var viewModel: QuizePageViewModel!
  var disposeBag: DisposeBag? = DisposeBag()
  
  override func viewDidLoad(){
    super.viewDidLoad()
    setupUI()
    bindData()
    // Do any additional setup after loading the view.
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    disposeBag = nil
  }
  func setupUI(){
    questionLabel.font = Appearance.fonts.captions()
    questionNumberLabel.font = Appearance.fonts.subheads()
    answersTableView.register(UINib(nibName: "AnswerCell", bundle: nil), forCellReuseIdentifier: CellIds.cellId.rawValue)
    answersTableView.separatorStyle = .none
    answersTableView.rx.setDelegate(self).disposed(by: disposeBag!)
    progressView.angle = 0
    
  }
  
  func bindData(){
    assert(viewModel != nil)
    let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
      .mapToVoid()
      .asDriverOnErrorJustComplete()
    
    let input = QuizePageViewModel.Input(viewWillAppearTrigger: viewWillAppear, selectedIndexPath: answersTableView.rx.itemSelected.asDriver())
    
    let output = viewModel.transform(input: input)
    output.answers.drive(answersTableView.rx.items(cellIdentifier: CellIds.cellId.rawValue, cellType: AnswerCell.self)){ item, viewModel, cell in
      cell.bindData(viewModel: viewModel)
    }.disposed(by: disposeBag!)
    output.didSelectedCorrectAnswer.drive().disposed(by: disposeBag!)
    output.questionText.drive(questionLabel.rx.text).disposed(by: disposeBag!)
    output.timerLabel.drive(timerLabel.rx.text).disposed(by: disposeBag!)
    output.questionNumber.drive(questionNumberLabel.rx.text).disposed(by: disposeBag!)
    output.answeringAction.drive().disposed(by: disposeBag!)
    output.timeOutAction.drive().disposed(by: disposeBag!)
    output.timer.drive().disposed(by: disposeBag!)
    output.timerProgress.asObservable().subscribe(onNext: { (current) in
      self.progressView.progress = current
    }).disposed(by: disposeBag!)
  }
  
}
extension QuizPageViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
    
  }
}
