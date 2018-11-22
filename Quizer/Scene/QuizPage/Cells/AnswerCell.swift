//
//  AnswerCell.swift
//  Quizer
//
//  Created by Behrad Kazemi on 11/21/18.
//  Copyright © 2018 Behrad Kazemi. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var borderedBackgroundView: UIView!
  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.font = Appearance.fonts.buttons()
    titleLabel.textColor = Appearance.colors.midGray()
    borderedBackgroundView.layer.cornerRadius = 10
    borderedBackgroundView.layer.borderWidth = 1.5
    borderedBackgroundView.layer.borderColor = Appearance.colors.midGray().cgColor
    
  }
  func bindData(viewModel: AnswerCellViewModel) {
    titleLabel.text = viewModel.title
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected {
      titleLabel.font = Appearance.fonts.buttonsSelected()
      titleLabel.textColor = Appearance.colors.darkGray()
      borderedBackgroundView.layer.borderWidth = 2
      borderedBackgroundView.layer.borderColor = Appearance.colors.blue().cgColor
      return
    }
    titleLabel.font = Appearance.fonts.buttons()
    titleLabel.textColor = Appearance.colors.midGray()
    borderedBackgroundView.layer.borderWidth = 1.5
    borderedBackgroundView.layer.borderColor = Appearance.colors.midGray().cgColor

  }
  
}
