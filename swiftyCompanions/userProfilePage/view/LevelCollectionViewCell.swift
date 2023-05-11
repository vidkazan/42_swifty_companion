//
//  UserProfileLevelCollectionViewCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 19.04.23.
//

import UIKit

class UserProfileLevelCell: UICollectionViewCell {
	static let identifier = "UserProfileLevelCell"
	var collectionView : UICollectionView?
	var levelWidthConstraint : NSLayoutConstraint?

	func configure(with data : UserProfileLevelCellData){
		self.levelContainer.text = data.levelLabel
		let width = CGFloat(Double((self.frame.width - 10)) * data.levelValue.truncatingRemainder(dividingBy: 1))
		removeConstraint(levelWidthConstraint!)
		levelWidthConstraint = levelLine.widthAnchor.constraint(equalToConstant: width)
		levelWidthConstraint?.isActive = true
		levelLine.backgroundColor = data.levelColor
		levelLine.setNeedsDisplay()
	}
	
	private let levelContainer : UILabel = {
		let l = UILabel()
		l.textColor = UIColor.CompanionColors.text
		l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
		l.textAlignment = .center
		return l
	}()
	
	private let levelLine = UIView()
	
	private let levelLineBackground : UIView = {
		let v = UIView()
		v.backgroundColor = UIColor.CompanionColors.primaryPlus1
		return v
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.CompanionColors.secondary
		
		self.layer
			.cornerRadius = Constants.CornerRadius.standart
		self.levelLine.layer
			.cornerRadius = Constants.CornerRadius.small
		self.levelLineBackground.layer
			.cornerRadius = Constants.CornerRadius.small
		
		addSubview(levelLineBackground)
		addSubview(levelLine)
		addSubview(levelContainer)
		
		levelContainer.translatesAutoresizingMaskIntoConstraints = false
		levelContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		levelContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
		levelContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive=true
		levelContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

		levelLineBackground.translatesAutoresizingMaskIntoConstraints = false
		levelLineBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		levelLineBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		levelLineBackground.heightAnchor.constraint(equalToConstant: 40).isActive = true
		levelLineBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5).isActive = true
		
		levelLine.translatesAutoresizingMaskIntoConstraints = false
		levelLine.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		levelLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		levelLine.heightAnchor.constraint(equalToConstant: 40).isActive = true
		levelWidthConstraint = levelLine.widthAnchor.constraint(equalTo: levelContainer.widthAnchor)
		levelWidthConstraint?.isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		levelContainer.text = ""
		levelWidthConstraint?.isActive = false
	}
}
