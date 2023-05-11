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
	func getBadgeCellData() -> UserProfileBadgeCellData {
		return UserProfileBadgeCellData(badges: generateBadges())
	}
	func getBlackholeDays(bhDateString : String?) -> String? {
		guard let bhDate = DateParcer.getDateFromDateString(dateString: bhDateString)  else {
			return nil
		}
		let interval = bhDate.timeIntervalSinceNow
		return String(abs(Int(interval / 86400)))
	}
	func generateBadges() -> [Badge] {
		var badges : [Badge] = []
		badges.append(Badge(color: self.userKind.color, name: self.userKind.text))
		if let bhDays = getBlackholeDays(bhDateString: getCursus()?.blackholedAt) {
			badges.append(Badge(color: BadgeTypes.bhDays(days: bhDays).color, name: BadgeTypes.bhDays(days: bhDays).text))
		}
		if let pm = user.poolMonth, let py = user.poolYear {
			let poolText : String = pm + " " + py
			badges.append(Badge(color: BadgeTypes.pool(pool: poolText).color, name: BadgeTypes.pool(pool: poolText).text))
		}
		if user.isStaff == true {
			badges.append(Badge(color: BadgeTypes.staff.color, name: BadgeTypes.staff.text))
			return badges
		}
		if user.isActive == false {
			badges.append(Badge(color: BadgeTypes.deactivated.color, name: BadgeTypes.deactivated.text))
			return badges
		}
		if user.isAlumni == true {
			badges.append(Badge(color: BadgeTypes.alimni.color, name: BadgeTypes.alimni.text))
			return badges
		}
		for language in user.languages_users {
			if let id = language.language_id {
				badges.append(Badge(color: BadgeTypes.language(languageId: id).color, name: BadgeTypes.language(languageId: id).text))
			}
		}
		badges.append(Badge(color: BadgeTypes.wallets(w: user.wallet ?? 0).color, name: BadgeTypes.wallets(w: user.wallet ?? 0).text))
		
		return badges
	}
}
