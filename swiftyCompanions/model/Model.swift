//
//  Model.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 14.04.23.
//

import Foundation
import UIKit

// MARK: ViewModel Models

struct Badge : Equatable {
	let color : UIColor
	let name : String
	
	init(color : UIColor, name : String){
		self.name = name
		self.color = color
	}
}

struct UserProfileProjectCellData : Equatable {
	static func == (lhs: UserProfileProjectCellData, rhs: UserProfileProjectCellData) -> Bool {
		if
			lhs.finalMarkLabelText == rhs.finalMarkLabelText,
			lhs.projectNameText == rhs.projectNameText,
			lhs.finalMarkLabelBackgroundColor == rhs.finalMarkLabelBackgroundColor,
			lhs.status.labelBGColor == rhs.status.labelBGColor,
			lhs.status.labelText == rhs.status.labelText
		{
			return true
		}
		return false
	}
	
	let status : ProjectStatus
	let projectNameText : String
	let finalMarkLabelText : String
	let finalMarkLabelBackgroundColor : UIColor
	
}
struct UserProfileProjectsCellData : Equatable {
	static func == (lhs: UserProfileProjectsCellData, rhs: UserProfileProjectsCellData) -> Bool {
		if lhs.projects == rhs.projects { return true }
			return false
	}
	
	let projects : [UserProfileProjectCellData]
}

struct UserProfileBadgeCellData : Equatable {
	static func == (lhs: UserProfileBadgeCellData, rhs: UserProfileBadgeCellData) -> Bool {
		if lhs.badges == rhs.badges{ return true }
		return false
	}
	
	let badges : [Badge]
}

struct UserProfileAvatarCellData {
	let loginLabel : String
	let displayNameLabel : String
	let campusLabel : String
	let locationLabel : String
	let emailLabel : String
	
	let displayLabelTextColor : UIColor
	static var onImageLoaded : ((UIImage?)->Void)?
}

struct UserProfileSkillsCellData {
	let skills : [Skill]
}

struct UserProfileLevelCellData {
	let levelLabel : String
	let levelValue : Double
	let cursusLabel : String
	let levelColor : UIColor
}

struct GraphData {
	var nameLabel : String?
	var valueTailLabel : String?
	var prevOverallValue: Int?
	var currOverallValue: Int?
	var currPointData: [(Int, Int)]?
}

struct UserProfileGraphsCellData {
	let loginGraphData : GraphData
	let evalsGraphData : GraphData
}

enum LoginSessionAnalyseType {
	case perDayAndSum
	case onlySum
}

enum ProjectStatus {
	case inProgress
	case waitingForEvaluation
	case finished(value : Int, validated : Bool)
	
	var labelText : String {
		switch self {
		case .inProgress,
			.waitingForEvaluation:
			return "in progress"
		case .finished(let value, _):
			return String(value)
		}
	}
	
	var labelBGColor : UIColor {
		switch self {
		case .inProgress, .waitingForEvaluation:
			return UIColor.CompanionColors.secondaryBright
		case .finished(_, let isValidated):
			switch isValidated{
			case false:
				return UIColor.CompanionColors.red
			case true:
				return UIColor.CompanionColors.green
			}
		}
	}
}

enum BadgeTypes {
	case pool(pool : String)
	case alimni
	case bhDays(days : String)
	case admin
	case staff
	case language(languageId : Int)
	case deactivated
	case wallets(w : Int)
	
	var color : UIColor {
		switch self {
		case .pool:
			return UIColor.CompanionColors.greenDark
		case .staff:
			return UIColor.CompanionColors.red
		case .alimni:
			return UIColor.CompanionColors.greenDark
		case .admin:
			return UIColor.CompanionColors.primary
		case .deactivated:
			return UIColor.CompanionColors.primary
		case .wallets:
			return .CompanionColors.yellow
		case .language:
			return UIColor.CompanionColors.blue
		case .bhDays:
			return UIColor.CompanionColors.red
		}
	}
		
	var text : String {
		switch self {
		case .pool(let pool):
			return pool
		case .deactivated:
			return "deactivated"
		case .wallets(let w):
			return "\(String(w)) wallets"
		case .language(let id):
			return Constants.languages[id] ?? ""
		case .alimni:
			return "alumni"
		case .admin:
			return "admin"
		case .staff:
			return "staff"
		case .bhDays(let days):
			return "\(days) days left"
		}
	}
}

enum Kind {
	case piscine
	case student
	case admin
	
	var text : String {
		switch self {
		case .piscine:
			return "piscine"
		case .student:
			return "student"
		case .admin:
			return "admin"
		}
	}
	
	var color : UIColor {
		switch self {
		case .piscine:
			return UIColor.CompanionColors.secondaryBright
		case .student:
			return UIColor.CompanionColors.green
		case .admin:
			return UIColor.CompanionColors.primaryPlus1
		}
	}
}

