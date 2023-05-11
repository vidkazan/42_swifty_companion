//
//  ViewController.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 12.04.23.
//

import UIKit

extension SearchUserViewController {
	func setupUI(){
		self.navigationItem.title = "Search 42 Users"
		
		self.navigationItem.titleView?.tintColor = UIColor.CompanionColors.textBright
		self.view.backgroundColor = UIColor.CompanionColors.primary
		
		view.addSubview(collectionView)
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.alwaysBounceVertical = true
		collectionView.bounces = true
		collectionView.tintColor = UIColor.CompanionColors.text
		collectionView.backgroundColor = UIColor.CompanionColors.primary
	}
}
