//
//  UserProfileViewController+CollectionVie.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 26.04.23.
//

import UIKit

enum UserProfileCollectionViewSections : Equatable {
	case avatar
	case level
	case badges
	case projects
	case graphs
	case skills
	
	var identifier : String {
		switch self {
		case .avatar:
			return UserProfileAvatarCell.identifier
		case .level:
			return UserProfileLevelCell.identifier
		case .badges:
			return UserProfileBadgesCollectionViewCell.identifier
		case .projects:
			return ProjectCollectionViewCell.identifier
		case .graphs:
			return GraphsCollectionViewCell.identifier
		case .skills:
			return SkillsCollectionViewCell.identifier
		}
	}
	
	func getSize(collectionViewFrame: CGRect, viewModel : UserProfileViewControllerViewModel) -> CGSize {
		switch self {
		case .avatar:
			return CGSize(width: Constants.cellWidth, height: 250)
		case .level:
			return CGSize(width: Constants.cellWidth, height: 50)
		case .badges:
			var height : CGFloat = 0
			let symbolCount  = viewModel.getBadgeCellData().badges.reduce(0) {
				$0 + $1.name.count
			}
			if symbolCount < 40 {
				height = 35
			} else if symbolCount < 80 {
				height = 65
			} else if symbolCount < 120 {
				height = 95
			} else if symbolCount < 160 {
				height = 125
			} else {
				height = 155
			}
			return CGSize(width: Constants.cellWidth, height: height)
		case .projects:
			return CGSize(width: Constants.cellWidth, height: 120)
		case .graphs:
			return CGSize(width: Constants.cellWidth, height: (collectionViewFrame.width - 30) / 2 )
		case .skills:
			let height = CGFloat(12 + Double(viewModel.getSkillsCellData()?.count ?? 0) * 0.32)
			
			return CGSize(width: Constants.cellWidth, height: height)
		}
	}
	
	func getCell (
		collectionView : UICollectionView,
		viewModel : UserProfileViewControllerViewModel,
		indexPath : IndexPath) -> UICollectionViewCell {
		switch self {
		case .avatar:
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: UserProfileAvatarCell.identifier,
				for: indexPath
			) as! UserProfileAvatarCell
			cell.configure(with: viewModel.getAvatarCellData())
			return cell
		case .level:
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: UserProfileLevelCell.identifier,
				for: indexPath) as! UserProfileLevelCell
			cell.configure(with: viewModel.getLevelCellData())
			return cell
		case .badges:
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: UserProfileBadgesCollectionViewCell.identifier,
				for: indexPath) as! UserProfileBadgesCollectionViewCell
			cell.configure(badgeData: viewModel.getBadgeCellData())
			return cell
		case .projects:
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: ProjectsCollectionViewCell.identifier,
				for: indexPath) as! ProjectsCollectionViewCell
			cell.configure(projectData: viewModel.getProjectsCellData())
			return cell
		case .graphs:
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: GraphsCollectionViewCell.identifier,
				for: indexPath) as! GraphsCollectionViewCell
			cell.configure(with: viewModel.getGraphsCellData())
			return cell
		case .skills:
			let cell = collectionView.dequeueReusableCell(
				withReuseIdentifier: SkillsCollectionViewCell.identifier,
				for: indexPath) as! SkillsCollectionViewCell
			cell.configure(with: viewModel.getSkillsCellData())
			return cell
		}
	}
}


extension UserProfileViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return self.sections.count
	}
	
	func collectionView(_ : UICollectionView, numberOfItemsInSection: Int) -> Int {
		return 1
		
	}

	func collectionView(_ collectionView : UICollectionView, cellForItemAt indexPath: IndexPath) ->  UICollectionViewCell {
		return self.sections[indexPath.section].getCell(
			collectionView: self.collectionView,
			viewModel: self.viewModel,
			indexPath: indexPath
		)
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return self.sections[indexPath.section].getSize(collectionViewFrame: self.collectionView.frame, viewModel: self.viewModel)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		   return UIEdgeInsets(
			   top: 5,
			   left: 0,
			   bottom: 0,
			   right: 0
		   )
	}
}
