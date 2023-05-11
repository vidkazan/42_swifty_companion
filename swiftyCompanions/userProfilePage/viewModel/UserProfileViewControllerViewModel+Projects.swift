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
	func analyseProjects() {
		for project in user.projects_users {
			let status : ProjectStatus = {
				switch project.status {
				case .inProgress:
					return .inProgress
				case .finished:
					return .finished(value: project.finalMark ?? -1, validated: project.validated ?? false)
				case .waitingForEvaluation:
					return .waitingForEvaluation
				case .unknown:
					return .finished(value: -1, validated: true)
				}
			}()
			if project.project.parentId == nil,
			   project.cursusIds.contains(getCursus()?.cursus.id ?? 0){
				self.projects.append(UserProfileProjectCellData(
					status: status,
					projectNameText: project.project.name ?? "",
					finalMarkLabelText: status.labelText,
					finalMarkLabelBackgroundColor: status.labelBGColor))
			}
		}
	}
	func getProjectsCellData() -> UserProfileProjectsCellData {
		return UserProfileProjectsCellData(projects: self.projects)
	}
}
