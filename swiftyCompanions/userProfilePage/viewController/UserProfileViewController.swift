//
//  UserProfileViewController.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 13.04.23.
//


import UIKit


class UserProfileViewController: UIViewController {
	var sections : [UserProfileCollectionViewSections] = [.avatar]
	let viewModel : UserProfileViewControllerViewModel
	var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(
			UserProfileAvatarCell.self,
			forCellWithReuseIdentifier: UserProfileAvatarCell.identifier)
		view.register(
			UserProfileLevelCell.self,
			forCellWithReuseIdentifier: UserProfileLevelCell.identifier)
		view.register(
			UserProfileBadgesCollectionViewCell.self,
			forCellWithReuseIdentifier: UserProfileBadgesCollectionViewCell.identifier)
		view.register(
			ProjectsCollectionViewCell.self,
			forCellWithReuseIdentifier: ProjectsCollectionViewCell.identifier)
		view.register(
			GraphsCollectionViewCell.self,
			forCellWithReuseIdentifier: GraphsCollectionViewCell.identifier)
		view.register(
			SkillsCollectionViewCell.self,
			forCellWithReuseIdentifier: SkillsCollectionViewCell.identifier)
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.CompanionColors.primary
		setupUI()
		self.navigationItem.title = viewModel.getAvatarCellData().loginLabel
		viewModel.onGraphData = { [weak self] in
			self?.updateView()
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		if self.isMovingFromParent {
			self.viewModel.requestsGgroupIdentifier = ""
			self.viewModel.onProfileViewWillDisAppear()
			self.viewModel.searchViewModel?.state = .onStart
		}
	}
	
	func updateView() {
		if let index = sections.firstIndex(of: .graphs)  {
			DispatchQueue.main.async {
				self.collectionView.reloadItems(at: [IndexPath(item: 0, section: index)])
			}
		}
	}
	
	init(viewModel : UserProfileViewControllerViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
			
		if viewModel.getLevelCellData().cursusLabel != "" {
			self.sections.append(.level)
		}
		self.sections.append(.badges)
		if viewModel.getProjectsCellData().projects.count > 0 {
			self.sections.append(.projects)
		}
		if let s = viewModel.user.isStaff, s == false {
			self.sections.append(.graphs)
		}
		if let cursus = viewModel.getCursus() , cursus.skills.count > 0 {
			self.sections.append(.skills)
		}
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
