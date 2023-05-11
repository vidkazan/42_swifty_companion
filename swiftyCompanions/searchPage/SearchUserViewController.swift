//
//  ViewController.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 12.04.23.
//

import UIKit

class SearchUserViewController : UIViewController {
	static public let now = Date()
	var viewModel : SearchUserViewControllerViewModel
	var magnifierImage : UIView?
	var searchController = UISearchController(searchResultsController: nil)
	var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.identifier)
		view.register(SearchEmptyResultCell.self, forCellWithReuseIdentifier: SearchEmptyResultCell.identifier)
		return view
	}()

	init(_ viewModel: SearchUserViewControllerViewModel = SearchUserViewControllerViewModel() ) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupSearchController()
		self.viewModel.onStateChange = { [ weak self ] state in
			switch state {
			case .onStart:
				self?.searchController.searchBar.setStopLoading(view: self?.magnifierImage)
			case .onLoading:
				self?.searchController.searchBar.setLoading()
			case .onNewData:
				DispatchQueue.main.async {
					self?.collectionView.reloadData()
					self?.searchController.searchBar.setStopLoading(view: self?.magnifierImage)
				}
			case .onError(error: let error, indexPath: let cellIndexPath):
				if let path = cellIndexPath {
					(self?.collectionView.cellForItem(at: path) as! SearchResultCell).deselectCell()
				}
				self?.searchController.searchBar.setStopLoading(view: self?.magnifierImage)
				DispatchQueue.main.async {
					let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
					switch error {
					case .cannotDecodeRawData,.cannotDecodeContentData,.badUrl,.cannotConnectToHost,.badServerResponse, .badRequest, .requestRateExceeded:
						alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
						alert.title = "Error"
						alert.message = error.description
						self?.present(alert, animated: true, completion: nil)
					case .unauthorised:
						alert.addAction(UIAlertAction(title: "Try to update token", style: .default, handler: {_ in
							do {
								try UserService.updateToken()
							}
							catch {
								self?.viewModel.state = .onError(error: .clientKeysError, indexPath: nil)
							}
						}))
						alert.title = "Error"
						alert.message = error.description
						self?.present(alert, animated: true, completion: nil)
					case .clientKeysError:
						alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
						alert.title = "Error"
						alert.message = error.description
						self?.present(alert, animated: true, completion: nil)
					}
				}
			case .onProfilePage(userModel: let userModel, indexPath: let cellIndexPath, requestGroupId: let requestGroupId):
				DispatchQueue.main.async {
					let vm = UserProfileViewControllerViewModel(userModel, requestsGgroupIdentifier : requestGroupId, searchVM: self?.viewModel)
					let userProfileViewController = UserProfileViewController(viewModel: vm)
					self?.navigationController?.pushViewController(userProfileViewController, animated: true)
					(self?.collectionView.cellForItem(at: cellIndexPath) as! SearchResultCell).deselectCell()
				}
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupNavigationController()
		do {
			try UserService.updateToken()
		}
		catch {
			self.viewModel.state = .onError(error: .clientKeysError, indexPath: nil)
		}
	}
}
