//
//  UserProfileAvatarViewCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 17.04.23.
//


import UIKit

class UserProfileAvatarCell: UICollectionViewCell {
	static let identifier = "UserProfileAvatarCell"
	
	func configure(with data : UserProfileAvatarCellData){
		self.layer.cornerRadius = Constants.CornerRadius.standart
		self.avatar.configure(image: nil, placeholder: data.displayNameLabel)
		self.name.text = data.displayNameLabel
		self.location.text = data.campusLabel + " | " + data.locationLabel
		self.email.text = data.emailLabel
		
		self.name.textColor = data.displayLabelTextColor
		
		UserProfileAvatarCellData.onImageLoaded = { [weak self] image in
			DispatchQueue.main.async {
				self?.avatar.configure(image: image, placeholder: "")
			}
		}
	}
	
	private let avatar = AvatarView(size: 150)

	private let name : UILabel = {
		let name = UILabel()
		name.textColor = UIColor.CompanionColors.textBright
		name.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
		name.numberOfLines = 2
		name.textAlignment = .center
		return name
	}()
	
	private let location : UILabel = {
		let l = UILabel()
		l.textColor = UIColor.CompanionColors.textHide
		l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		l.textAlignment = .center
		return l
	}()
	private let email : UILabel = {
		let l = UILabel()
		l.textColor = UIColor.CompanionColors.textHide
		l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		l.textAlignment = .center
		return l
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	func setupUI() {
		self.backgroundColor = UIColor.CompanionColors.secondary
		addSubview(avatar)
		addSubview(name)
		addSubview(location)
		addSubview(email)
		
		avatar.translatesAutoresizingMaskIntoConstraints = false
		avatar.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
		avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		avatar.heightAnchor.constraint(equalToConstant: 150).isActive = true
		avatar.widthAnchor.constraint(equalToConstant: 150).isActive = true

		name.translatesAutoresizingMaskIntoConstraints = false
		name.topAnchor.constraint(equalTo: avatar.bottomAnchor,constant: 5).isActive = true
		name.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		name.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5).isActive = true
		name.heightAnchor.constraint(equalToConstant: 30).isActive = true

		location.translatesAutoresizingMaskIntoConstraints = false
		location.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
		location.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		location.heightAnchor.constraint(equalToConstant: 20).isActive = true
		location.widthAnchor.constraint(equalTo: name.widthAnchor).isActive = true

		email.translatesAutoresizingMaskIntoConstraints = false
		email.topAnchor.constraint(equalTo: location.bottomAnchor).isActive = true
		email.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		email.heightAnchor.constraint(equalToConstant: 20).isActive = true
		email.widthAnchor.constraint(equalTo: name.widthAnchor).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
