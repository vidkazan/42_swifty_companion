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
	func getSkillsCellData() -> String? {
		guard let skills = getCursus()?.skills else { return nil }
		var str = ""
		for skill in skills  {
			if let name = skill.name, let level = skill.level {
				let label = "\(name) \(String(level).prefix(4))"
				str.append("\(label), ")
			}
		}
		let res = str.dropLast(2)
		return String(res)
	}
}
