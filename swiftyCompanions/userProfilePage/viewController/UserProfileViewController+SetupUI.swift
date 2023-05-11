//
//  UserProfileViewController+SetupUI.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import UIKit

extension UserProfileViewController {
	func setupUI(){
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.tintColor = UIColor.CompanionColors.text
		collectionView.backgroundColor = UIColor.CompanionColors.primary
	}
}

