//
//  ModelJSON.swift.swift
//  swifty_companion
//
//  Created by Dmitrii Grigorev on 21.04.23.
//

import Foundation

// MARK: JSON decoding models

struct Campus : Decodable {
	let name: String?
	let website: String?
}

struct CursusUser : Decodable {
	enum CodingKeys : String, CodingKey {
			case grade
			case level
			case blackholedAt = "blackholed_at"
			case beginAt = "begin_at"
			case endAt = "end_at"
			case cursus
			case skills
		}
	let skills : [Skill]
	let grade: String?
	let level: Double?
	let blackholedAt: String?
	let beginAt: String?
	let endAt: String?
	let cursus: Cursus
}

struct Cursus : Decodable {
	let id : Int?
	let name: String?
}

struct LanguagesUser : Decodable {
	let language_id, position: Int?
}


enum Status: Decodable {
	case inProgress, finished, waitingForEvaluation
	case unknown(value: String)
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let status = try? container.decode(String.self)
		switch status {
			case "finished": self = .finished
			case "in_progress": self = .inProgress
			case "waiting_for_correction": self = .waitingForEvaluation
			  default:
				 self = .inProgress
		  }
	  }
}

struct ProjectsUser : Decodable {
	enum CodingKeys : String, CodingKey {
		case id,
			 occurrence,
			 finalMark = "final_mark",
			 status,
			 validated = "validated?",
			 currentTeamID,
			 cursusIds = "cursus_ids",
			 project,
			 markedAt,
			 marked,
			 retriableAt,
			 createdAt,
			 updatedAt
	}
	let id: Int?
	let occurrence: Int?
	let finalMark: Int?
	let status: Status
	let validated: Bool?
	let currentTeamID: Int?
	let cursusIds: [Int]
	let project: Project
	let markedAt: String?
	let marked: Bool?
	let retriableAt: String?
	let createdAt, updatedAt: String?
}

struct Project : Decodable {
	enum CodingKeys : String, CodingKey {
		case id,
			 name,
			 parentId = "parent_id"
	}
	let id: Int?
	let name: String?
	let parentId: Int?
}

struct TokenDataJSON : Decodable {
	let access_token	: String?
	let expires_in		: Int?
	let created_at		: Int64?
}

struct UserSearchJSON : Decodable {
	
	enum CodingKeys : String, CodingKey {
			case id,
				 email,
				 login,
				 firstName,
				 lastName,
				 url,
				 phone,
				 displayname,
				 kind,
				 image,
				 correctionPoin,
				 poolMonth = "pool_month",
				 poolYear = "pool_year",
				 location,
				 wallet
			case isStaff = "staff?"
			case isAlumni = "alumni?"
			case isActive = "active?"
		}
	let id				: Int
	let email			: String?
	let login			: String?
	let firstName		: String?
	let lastName		: String?
	let url				: String?
	let phone			: String?
	let displayname		: String?
	let kind			: String?
	let image			: UsersUserImageJSON
	let isStaff			: Bool?
	let correctionPoin	: Int?
	let poolMonth 		: String?
	let poolYear		: String?
	let location		: String?
	let wallet			: Int?
	let isAlumni		: Bool?
	let isActive		: Bool?
}

struct UserModel : Decodable {
	enum CodingKeys : String, CodingKey {
			case id,
				 email,
				 login,
				 firstName,
				 lastName,
				 url,
				 phone,
				 displayname,
				 kind,
				 image,
				 correctionPoin,
				 poolMonth = "pool_month",
				 poolYear = "pool_year",
				 location,
				 wallet,
				 cursus_users,
				 projects_users,
				 languages_users,
				campus
			case isStaff = "staff?"
			case isAlumni = "alumni?"
			case isActive = "active?"
		}
	let id				: Int
	let email			: String?
	let login			: String?
	let firstName		: String?
	let lastName		: String?
	let url				: String?
	let phone			: String?
	let displayname		: String?
	let kind			: String?
	let image			: UsersUserImageJSON
	let isStaff			: Bool?
	let correctionPoin	: Int?
	let poolMonth 		: String?
	let poolYear		: String?
	let location		: String?
	let wallet			: Int?
	let isAlumni		: Bool?
	let isActive		: Bool?
	let cursus_users: [CursusUser]
	let projects_users: [ProjectsUser]
	let languages_users: [LanguagesUser]
	let campus: [Campus]
}

struct Skill : Decodable {
	let id		: Int?
	let name	: String?
	let level	: Double?
}

struct UsersUserImageJSON : Decodable {
	let link: String?
	let versions: UsersUserImageVersionsJSON
}

struct UsersUserImageVersionsJSON : Decodable {
	let large	: String?
	let medium	: String?
	let small	: String?
	let micro	: String?
}

struct ProjectTeam : Decodable {
	enum CodingKeys : String, CodingKey {
		case finalMark		= "final_mark"
		case projectId		= "project_id"
		case createdAt		= "created_at"
		case status
		case isLocked		= "locked?"
		case isValidated	= "validated?"
		case isClosed		= "closed?"
		case projectSessionID = "project_session_id"
	}
	let finalMark	: Int?
	let projectId	: Int?
	let createdAt	: String?
	let status		: String?
	let isLocked	: Bool?
	let isValidated	: Bool?
	let isClosed	: Bool?
	let projectSessionID : Int?
}

struct LoginSession : Decodable {
	enum CodingKeys : String, CodingKey {
		case beginAt = "begin_at"
		case endAt = "end_at"
	}
	let endAt, beginAt: String?
}

struct ScaleTeam : Decodable {
	enum CodingKeys : String, CodingKey {
		case filledAt = "begin_at"
	}
	let filledAt: String?
}
