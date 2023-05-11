//
//  PaddingLabel.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import UIKit

class PaddingLabel: UILabel {
	
	private var topInset	: CGFloat = 4
	private var bottomInset	: CGFloat = 4
	private var leftInset	: CGFloat = 4
	private var rightInset	: CGFloat = 4
	
	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
		super.drawText(in: rect.inset(by: insets))
	}
	
	override var intrinsicContentSize: CGSize {
		let size = super.intrinsicContentSize
		guard let count = self.text?.count else {
			return CGSize(width: size.width,height: size.height)
		}
		if count > 0 {
			return CGSize(width: size.width + leftInset + rightInset,
						  height: size.height + topInset + bottomInset)
			
		} else {
			return CGSize(width: size.width,height: size.height)
		}

	}
	init(inset : CGFloat = 4){
		super.init(frame: .zero)
		topInset = inset
		bottomInset = inset
		leftInset = inset
		rightInset = inset
	}
	init(inset : Int = 4, bgColor : UIColor = UIColor.CompanionColors.yellow, textColor : UIColor = UIColor.CompanionColors.text){
		super.init(frame: .zero)
		self.backgroundColor = bgColor
		self.textColor = textColor
		self.layer.masksToBounds = true
	}
	func setInsets(tInset : CGFloat,bInset : CGFloat,lInset : CGFloat,rInset : CGFloat ){
		topInset = tInset
		bottomInset = bInset
		leftInset = lInset
		rightInset = rInset
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

