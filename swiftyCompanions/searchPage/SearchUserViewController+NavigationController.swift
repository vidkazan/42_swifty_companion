//
//  ViewController.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 12.04.23.
//

import UIKit

extension SearchUserViewController {
	func setupNavigationController() {
		navigationController?.navigationBar.prefersLargeTitles = true

		let appearance = UINavigationBarAppearance()
		appearance.shadowColor = nil
		appearance.backgroundColor = UIColor.CompanionColors.primary
		appearance.titleTextAttributes = [.foregroundColor: UIColor.CompanionColors.textSecondary]
		appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.CompanionColors.textSecondary]

		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
	}
}
