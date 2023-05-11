//
//  ProjectsCollectionViewCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 20.04.23.
//

import UIKit

class SkillsCollectionViewCell: UICollectionViewCell {
	static let identifier = "SkillsCollectionViewCell"
	
	let skillsLabel : UILabel = {
		let skillsLabel = UILabel()
		skillsLabel.textColor = UIColor.CompanionColors.textHide
		skillsLabel.font = UIFont.systemFont(ofSize: 11, weight: .ultraLight)
		skillsLabel.numberOfLines = 0
		skillsLabel.lineBreakMode = .byWordWrapping
		return skillsLabel
	}()
	
	public func configure(with skills : String?) {
				skillsLabel.text = skills ?? ""
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupViews(){
		self.layer.cornerRadius = Constants.CornerRadius.standart
//		self.backgroundColor = UIColor.CompanionColors.primaryPlus1
		addSubview(skillsLabel)
		
		skillsLabel.translatesAutoresizingMaskIntoConstraints = false
		skillsLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
		skillsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5).isActive = true
		skillsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		skillsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5).isActive = true
	}
}
