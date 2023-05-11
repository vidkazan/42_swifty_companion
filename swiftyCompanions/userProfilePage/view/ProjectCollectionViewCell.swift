//
//  ProjectCollectionViewCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 20.04.23.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {
	static let identifier = "ProjectCollectionViewCell"
	
	public func configure(with project : UserProfileProjectCellData){
		self.name.text = project.projectNameText
		self.result.text = project.finalMarkLabelText
		self.resultBG.backgroundColor = project.finalMarkLabelBackgroundColor
		self.clipsToBounds = true
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let name : UILabel = {
		let date = UILabel()
		date.font = date.font.withSize(14)
		date.numberOfLines = 2
		date.text = "error"
		date.textColor = UIColor.CompanionColors.text
		return date
	}()

	private let resultBG : UIView = {
		let v = UIView()
		v.backgroundColor = UIColor.CompanionColors.green
		return v
	}()
	
	let result : UILabel = {
		let date = UILabel()
		date.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
		date.text = "error"
		date.textColor = UIColor.CompanionColors.text
		return date
	}()
	
	func setupViews(){
		self.backgroundColor = UIColor.CompanionColors.primaryPlus1
		self.layer.cornerRadius = Constants.CornerRadius.small
		addSubview(name)
		addSubview(resultBG)
		resultBG.addSubview(result)
		
		name.translatesAutoresizingMaskIntoConstraints = false
		name.topAnchor.constraint(equalTo: self.topAnchor,constant: 12).isActive = true
		name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
		name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
		name.textAlignment = .center
		
		resultBG.translatesAutoresizingMaskIntoConstraints = false
		resultBG.layer.cornerRadius = Constants.CornerRadius.small
		resultBG.heightAnchor.constraint(equalToConstant: 25).isActive = true
		resultBG.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
		resultBG.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
		resultBG.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
		
		result.translatesAutoresizingMaskIntoConstraints = false
		result.centerYAnchor.constraint(equalTo: self.resultBG.centerYAnchor).isActive = true
		result.centerXAnchor.constraint(equalTo: self.resultBG.centerXAnchor).isActive = true
		result.textAlignment = .center
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
}
