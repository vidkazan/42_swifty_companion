//
//  AvatarView.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import UIKit

class AvatarView: UIView {
	let size : CGFloat
	init(size : CGFloat) {
		self.size = size
		super.init(frame: .zero)
		avatar.layer.cornerRadius = size / 2
		blurEffectView.layer.cornerRadius = avatar.layer.cornerRadius
		name.font = UIFont.systemFont(ofSize: size / 4, weight: .semibold)
		setupUI()
	}
	
	func configure(image: UIImage?, placeholder: String = "") {
		if let image = image {
			self.name.text = ""
			self.avatar.image = image
		} else {
			let words = placeholder.split(separator: " ")
			if let first = words.first?.first,
			   let second = words.last?.first {
				self.name.text = "\(first) \(second)"
			}
		}
	}
	
	let blurEffectView : UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.clipsToBounds = true
		return blurEffectView
	}()
	
	let avatar : UIImageView = {
		let view = UIImageView()
		view.backgroundColor = UIColor.CompanionColors.primaryPlus1
		view.layer.masksToBounds = true
		view.contentMode = .scaleAspectFill
		return view
	}()
	
	let name : UILabel = {
		let name = UILabel()
		name.textColor = UIColor.CompanionColors.textHide
		name.numberOfLines = 1
		name.textAlignment = .center
		return name
	}()
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupUI(){
		addSubview(avatar)
		addSubview(name)
		addSubview(blurEffectView)
		avatar.translatesAutoresizingMaskIntoConstraints = false
		name.translatesAutoresizingMaskIntoConstraints = false
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		
		name.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		name.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		name.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		name.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		
		avatar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		avatar.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		avatar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		
		blurEffectView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		blurEffectView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		blurEffectView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		blurEffectView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		
		self.blurEffectView.isHidden = true
	}
}
