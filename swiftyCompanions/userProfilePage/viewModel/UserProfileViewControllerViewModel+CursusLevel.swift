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
	func getLevelCellData() -> UserProfileLevelCellData {
		let cursus = self.getCursus()
		let levelColor : UIColor = {
			let levelColorHue = 0.2 + 0.03 * (cursus?.level ?? 0)
			return UIColor(hue: levelColorHue, saturation: 0.8, brightness: 0.4, alpha: 1)
		}()
		switch userKind {
		case .piscine, .student:
			return UserProfileLevelCellData(
				levelLabel: getLevelLabelText(c: cursus),
				levelValue: cursus?.level ?? 0.0,
				cursusLabel: cursus?.cursus.name ?? "",
				levelColor: levelColor
			)
		case .admin:
			return UserProfileLevelCellData(
				levelLabel: "",
				levelValue: 0,
				cursusLabel: "",
				levelColor: UIColor.CompanionColors.primaryPlus1
			)
		}
	}
	func getCursus() -> CursusUser? {
		let cursus = user.cursus_users.filter { $0.cursus.name == "42cursus" }
		if !cursus.isEmpty {
			return cursus.first
		} else {
			return user.cursus_users.first
		}
	}
	
	private func getLevelLabelText(c : CursusUser?) -> String {
		guard
			let c = c,
			let level = c.level,
			let name = c.cursus.name else { return "" }
		return name + ": " + "level \(String(level))"
	}
}
