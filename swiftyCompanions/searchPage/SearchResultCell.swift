//
//  SearchResultCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 12.04.23.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
	static let identifier = "SearchResultCell"
	
	public func selectCell(){
		self.avatar.blurEffectView.isHidden = false
		self.loader.isHidden = false
	}
	public func deselectCell(){
		self.loader.isHidden = true
		self.avatar.blurEffectView.isHidden = true
	}
	public func configure(with data: UserSearchJSON) {
		self.loader.isHidden = false
		self.backgroundColor = UIColor.CompanionColors.secondary
		self.layer.cornerRadius = Constants.CornerRadius.standart
		self.desc.text = "@\(data.login ?? "")"
		self.name.text = data.displayname
		self.avatar.configure(image: nil, placeholder: data.displayname ?? "")
		if(data.isActive == false) {
			deactivatedUserCellStyle()
		} else {
			self.kind.text = data.kind == "student" ? "" : data.kind
			self.staff.text = data.isStaff == true ? "staff" : ""
			self.alumni.text = data.isAlumni == true ? "alumni" : ""
			self.name.textColor = UIColor.CompanionColors.textBright
			self.deactivated.text = ""
		}
		
		if let path = data.image.versions.medium {
			UserService.fetch(
				Data.self,
				query: [],
				type: UserService.Requests.customGet(path: path),
				requestGroupId: ""
			){ [weak self] result in
				guard let self = self else { return }
				switch result {
				case .success(let res) :
					self.avatar.configure(image: UIImage(data: res), placeholder: "")
				case .failure(let error) :
					break
				}
			}
		}
		self.loader.isHidden = true
	}
	
	func deactivatedUserCellStyle(){
		self.name.textColor = UIColor.CompanionColors.textHide
		self.deactivated.text = "deactivated"
		self.staff.text = ""
		self.kind.text = ""
	}

	private let avatar = AvatarView(size: 80)

	let loader : UIActivityIndicatorView = {
		let l = UIActivityIndicatorView()
		l.hidesWhenStopped = true
		l.style = UIActivityIndicatorView.Style.medium
		l.color = UIColor.CompanionColors.textHide
		l.startAnimating()
		return l
	}()
	private let name : UILabel = {
		let name = UILabel()
		name.textColor = UIColor.CompanionColors.textBright
		name.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
		name.textAlignment = .left
		return name
	}()
	
	private let desc : UILabel = {
		let desc = UILabel()
		desc.font = desc.font.withSize(13)
		desc.textColor = UIColor.CompanionColors.textHide
		return desc
	}()
	
	private let kind : PaddingLabel = {
		let date = PaddingLabel()
		date.font = date.font.withSize(11)
		date.backgroundColor = UIColor.CompanionColors.primary
		date.layer.masksToBounds = true
		date.layer.cornerRadius = 10
		date.textColor = UIColor.CompanionColors.textSecondary
		return date
	}()
	
	private let staff : PaddingLabel = {
		let https = PaddingLabel()
		https.font = https.font.withSize(11)
		https.backgroundColor = UIColor.CompanionColors.red
		https.layer.masksToBounds = true
		https.layer.cornerRadius = 10
		https.textColor = UIColor.CompanionColors.textSecondary
		return https
	}()
	
	private let alumni : PaddingLabel = {
		let https = PaddingLabel()
		https.font = https.font.withSize(11)
		https.backgroundColor = UIColor.CompanionColors.green
		https.layer.masksToBounds = true
		https.layer.cornerRadius = 10
		https.textColor = UIColor.CompanionColors.textSecondary
		return https
	}()
	
	private let deactivated : PaddingLabel = {
		let label = PaddingLabel()
		label.font = label.font.withSize(11)
		label.backgroundColor = UIColor.CompanionColors.textHide
		label.layer.masksToBounds = true
		label.layer.cornerRadius = 10
		label.textColor = UIColor.CompanionColors.primary
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(avatar)
		addSubview(loader)
		addSubview(name)
		addSubview(desc)
		addSubview(kind)
		addSubview(staff)
		addSubview(deactivated)
		addSubview(alumni)
		
		loader.translatesAutoresizingMaskIntoConstraints = false
		loader.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
		loader.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
		loader.heightAnchor.constraint(equalToConstant: 80).isActive = true
		loader.widthAnchor.constraint(equalToConstant: 80).isActive = true
		
		avatar.translatesAutoresizingMaskIntoConstraints = false
		avatar.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
		avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
		avatar.heightAnchor.constraint(equalToConstant: 80).isActive = true
		avatar.widthAnchor.constraint(equalToConstant: 80).isActive = true
		
		name.lineBreakMode = .byWordWrapping
		name.numberOfLines = 0
		name.textAlignment = .left
		name.translatesAutoresizingMaskIntoConstraints = false
		name.topAnchor.constraint(equalTo: avatar.topAnchor).isActive = true
		name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10).isActive = true
		name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
		
		desc.translatesAutoresizingMaskIntoConstraints = false
		desc.textAlignment = .left
		desc.translatesAutoresizingMaskIntoConstraints = false
		desc.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
		desc.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10).isActive = true

		kind.translatesAutoresizingMaskIntoConstraints = false
		kind.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
		kind.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true

		staff.translatesAutoresizingMaskIntoConstraints = false
		staff.trailingAnchor.constraint(equalTo: self.kind.leadingAnchor,constant: -5).isActive = true
		staff.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true

		deactivated.translatesAutoresizingMaskIntoConstraints = false
		deactivated.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
		deactivated.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
		
		alumni.translatesAutoresizingMaskIntoConstraints = false
		alumni.trailingAnchor.constraint(equalTo: self.deactivated.leadingAnchor,constant: -5).isActive = true
		alumni.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true

	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func prepareForReuse() {
		super.prepareForReuse()
		self.avatar.avatar.image = nil
		self.avatar.name.text = ""
		self.loader.startAnimating()
		self.loader.isHidden = false
		self.alumni.text = nil
		self.deactivated.text = nil
		self.desc.text = nil
		self.staff.text = nil
		self.kind.text = nil
		self.name.text = nil
	}
}
