//
//  EvalResultLabel.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import UIKit

class EvalResultLabel : PaddingLabel {
	init(text : String){
		super.init(bgColor: UIColor.CompanionColors.greenDark, textColor: UIColor.CompanionColors.textHide)
		self.setInsets(tInset: 8, bInset: 8, lInset: 12, rInset: 12)
		self.layer.cornerRadius = Constants.CornerRadius.small
		self.font = UIFont.systemFont(ofSize: 11, weight: .regular)
		self.text = text
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
