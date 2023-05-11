//
//  BadgeCollectionViewCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 20.04.23.
//

import UIKit

class BadgeCollectionViewCell: UICollectionViewCell {
	static let identifier = "BadgeCollectionViewCell"
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with badge : Badge){
		self.kind.text = badge.name
		self.kind.backgroundColor = badge.color
	}
	
	let kind : PaddingLabel = {
		let date = PaddingLabel()
		date.font = date.font.withSize(14)
		date.layer.masksToBounds = true
		date.textColor = UIColor.CompanionColors.textBright
		date.layer.cornerRadius = Constants.CornerRadius.small
		return date
	}()
	
	func setupViews(){
		self.layer.cornerRadius = Constants.CornerRadius.standart
		addSubview(kind)
		
		kind.translatesAutoresizingMaskIntoConstraints = false
		kind.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		kind.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		kind.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		kind.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		kind.numberOfLines = 0
		kind.textAlignment = .center
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		kind.text = ""
	}
}
