//
//  ProjectsCollectionViewCell.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 20.04.23.
//

import UIKit

class ProjectsCollectionViewCell: UICollectionViewCell {
	static let identifier = "ProjectsCollectionViewCell"
	var projectsDataSourse : [UserProfileProjectCellData] = []
	
	public func configure(projectData : UserProfileProjectsCellData) {
		self.projectsDataSourse = projectData.projects
	}
	
	var collectionView : UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.register(ProjectCollectionViewCell.self, forCellWithReuseIdentifier: ProjectCollectionViewCell.identifier)
		return view
	}()
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupViews(){
		addSubview(collectionView)
		self.layer.cornerRadius = Constants.CornerRadius.standart
		self.backgroundColor = UIColor.CompanionColors.secondary
		collectionView.backgroundColor = UIColor.CompanionColors.secondary
		collectionView.layer.cornerRadius = Constants.CornerRadius.small
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5).isActive = true
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
}

extension ProjectsCollectionViewCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

	func collectionView(_ : UICollectionView, numberOfItemsInSection: Int) -> Int {
		return projectsDataSourse.count
	}
	func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath: IndexPath) ->  UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectCollectionViewCell.identifier, for: indexPath)
		as! ProjectCollectionViewCell
		cell.configure(with: projectsDataSourse[indexPath.row])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.collectionView.frame.height, height: self.collectionView.frame.height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1 // Specify the minimum spacing between cells horizontally
	}
}
