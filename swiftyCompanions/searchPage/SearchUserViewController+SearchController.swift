//
//  ViewController.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 12.04.23.
//

import UIKit

extension SearchUserViewController : UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		viewModel.updateSearchText(text: self.searchController.searchBar.text)
	}
	
	func setupSearchController(){
		self.magnifierImage = self.searchController.searchBar.searchTextField.leftView
		self.searchController.searchResultsUpdater = self
		self.searchController.searchBar.delegate = self
		self.searchController.searchBar.setShowsCancelButton(false, animated: false)
		self.searchController.searchBar.tintColor = UIColor.CompanionColors.text
		self.searchController.searchBar.searchTextField.textColor = .white
		self.searchController.searchBar.barStyle = .black
		self.searchController.hidesNavigationBarDuringPresentation = false
		self.searchController.searchBar.placeholder = "Search"
		self.navigationItem.searchController = self.searchController
	}
}

extension SearchUserViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.viewModel.fetchUsers(filter: searchBar.text)
	}
}

extension UISearchBar {
	func setLoading() {
		let activityIndicator = UIActivityIndicatorView(style: .medium)
		activityIndicator.color = .gray
				activityIndicator.startAnimating()
				self.searchTextField.leftView = activityIndicator
				self.searchTextField.leftViewMode = .always
	}
	func setStopLoading(view : UIView?) {
				self.searchTextField.leftView = view
	}
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
			
		searchBar.resignFirstResponder()
	}
}


