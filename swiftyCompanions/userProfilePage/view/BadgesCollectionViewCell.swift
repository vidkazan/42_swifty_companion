//
//  UserProfileBadgesCollectionViewCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 20.04.23.
//

import UIKit

class UserProfileBadgesCollectionViewCell: UICollectionViewCell {
	static let identifier = "UserProfileBadgesCollectionViewCell"
	var badgesDataSourse : [Badge] = []
	
	var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(BadgeCollectionViewCell.self, forCellWithReuseIdentifier: BadgeCollectionViewCell.identifier)
		return view
	}()
	
	public func configure(badgeData : UserProfileBadgeCellData) {
		self.badgesDataSourse = badgeData.badges
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.CompanionColors.secondary
		self.layer.cornerRadius = Constants.CornerRadius.standart
		setupUI()
	}
	
	func setupUI(){
		addSubview(collectionView)
		collectionView.backgroundColor = UIColor.CompanionColors.secondary
		collectionView.layer.cornerRadius = Constants.CornerRadius.standart
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
		collectionView.delegate = self
		collectionView.dataSource = self
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
		
	}
}

extension UserProfileBadgesCollectionViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

	func collectionView(_ : UICollectionView, numberOfItemsInSection: Int) -> Int {
		return badgesDataSourse.count
	}
	func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath: IndexPath) ->  UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.identifier, for: indexPath)
			as! BadgeCollectionViewCell
		cell.configure(with: badgesDataSourse[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 5 // Specify the minimum spacing between cells vertically
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 5 // Specify the minimum spacing between cells horizontally
	}
}
	

