//
//  UserProfileViewControllerViewModel.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 21.04.23.
//

import Foundation
import UIKit
import DequeModule


extension UserProfileViewControllerViewModel {
	func getAvatarCellData() -> UserProfileAvatarCellData {
		return UserProfileAvatarCellData(
			loginLabel : user.login != nil ? "@\(user.login!)" : "",
			displayNameLabel: user.displayname ?? "",
			campusLabel: user.campus.last?.name != nil ? "\(user.campus.last!.name!)" : "",
			locationLabel: user.location ?? "unavailable",
			emailLabel: user.email ?? "",
			displayLabelTextColor: user.isActive == true ?
				UIColor.CompanionColors.textSecondary :
				UIColor.CompanionColors.textHide
		)
	}
	
	func loadImage(){
		guard let path = user.image.versions.large else {
			return
		}
		UserService.fetch(
			Data.self,
			query: [],
			type: UserService.Requests.customGet(path: path),
			requestGroupId: ""
		) { result in
			 switch result {
			 case .success(let res) :
				 let image = UIImage(data: res)
				 UserProfileAvatarCellData.onImageLoaded?(image)
			 case .failure(let error) :
				 break
			 }
		}
	}
}
