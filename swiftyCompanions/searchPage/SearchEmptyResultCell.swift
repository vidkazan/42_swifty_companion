//
//  SearchResultCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 12.04.23.
//

import UIKit

class SearchEmptyResultCell: UICollectionViewCell {
	static let identifier = "SearchEmptyResultCell"
	
	public func selectCell(){
	}
	public func deselectCell(){
	}
	
	public func configure(description : String?) {
		self.name.text = description ?? ""
	}
	
	private let name : UILabel = {
		let name = UILabel()
		name.textColor = UIColor.CompanionColors.textHide
		name.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		name.textAlignment = .center
		return name
	}()

	
	override init(frame: CGRect) {
		super.init(frame: frame)
	
		addSubview(name)
		
		
		name.lineBreakMode = .byWordWrapping
		name.numberOfLines = 0
		name.translatesAutoresizingMaskIntoConstraints = false
		name.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
//		name.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
		name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func prepareForReuse() {
		super.prepareForReuse()
		self.name.text = nil
	}
}
