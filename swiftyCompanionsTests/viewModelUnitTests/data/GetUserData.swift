//
//  GetUserResults.swift
//  swiftyCompanionsTests
//
//  Created by Dmitrii Grigorev on 29.04.23.
//

import Foundation
import UIKit
@testable import swiftyCompanions

struct GetUserResultsLoginFcody {
	static let loginGraphSourceDataMonthPrevious : [LoginSession] = [
		swiftyCompanions.LoginSession(endAt: Optional("2023-04-21T09:05:52.923Z"), beginAt: Optional("2023-04-21T08:54:18.173Z")),
		swiftyCompanions.LoginSession(endAt: Optional("2023-04-21T08:42:12.875Z"), beginAt: Optional("2023-04-21T08:39:23.567Z")),
		swiftyCompanions.LoginSession(endAt: Optional("2023-04-14T20:10:00.146Z"), beginAt: Optional("2023-04-14T17:31:52.633Z")),
		swiftyCompanions.LoginSession(endAt: Optional("2023-04-14T17:08:46.677Z"), beginAt: Optional("2023-04-14T17:06:16.230Z")),
		swiftyCompanions.LoginSession(endAt: Optional("2023-04-14T17:05:46.122Z"), beginAt: Optional("2023-04-14T16:00:29.784Z")),
		swiftyCompanions.LoginSession(endAt: Optional("2023-04-14T13:49:54.646Z"), beginAt: Optional("2023-04-14T10:49:09.819Z")),
		swiftyCompanions.LoginSession(endAt: Optional("2023-04-13T16:59:50.054Z"), beginAt: Optional("2023-04-13T14:38:27.150Z"))
	]
	static let loginGraphSourceDataMonthBeforePrevious : [LoginSession] = []

	static let evalGraphSourceDataMonthPrevious : [ScaleTeam] = [
	]
	static let evalsGraphSourceDataMonthBeforePrevious : [ScaleTeam] = []
	
	static let sourceData : UserModel = UserModel(
		id: 85646,
		email: Optional("fcody@student.42wolfsburg.de"),
		login: Optional("fcody"),
		firstName: nil,
		lastName: nil,
		url: Optional("https://api.intra.42.fr/v2/users/fcody"),
		phone: Optional("hidden"),
		displayname: Optional("Dmitrii Grigorev"),
		kind: Optional("student"),
		image: swiftyCompanions.UsersUserImageJSON(
			link: Optional("https://cdn.intra.42.fr/users/f98f7c2c562b4cc07949a6b02dfddd58/fcody.jpg"),
			versions: swiftyCompanions.UsersUserImageVersionsJSON(
				large: Optional("https://cdn.intra.42.fr/users/fa029ec70a68487c0b200d72591481ad/large_fcody.jpg"),
				medium: Optional("https://cdn.intra.42.fr/users/772bda1478c238322f8b4ef8144a80ee/medium_fcody.jpg"),
				small: Optional("https://cdn.intra.42.fr/users/5073630b4fb12780f870b179d08b05b5/small_fcody.jpg"),
				micro: Optional("https://cdn.intra.42.fr/users/cad6d468fb5fa2c595fe9c9e14d406e2/micro_fcody.jpg"))),
		isStaff: Optional(false),
		correctionPoin: nil, poolMonth: Optional("march"),
		poolYear: Optional("2021"),
		location: nil,
		wallet: Optional(1070),
		isAlumni: Optional(false),
		isActive: Optional(true),
		cursus_users: [
			swiftyCompanions.CursusUser(
				skills: [], grade: nil,
				level: Optional(5.97),
				blackholedAt: nil,
				beginAt: Optional("2021-03-01T08:00:00.000Z"),
				endAt: Optional("2021-03-27T08:00:00.000Z"),
				cursus: swiftyCompanions.Cursus(
					id: Optional(9),
					name: Optional("C Piscine"))
			),
			swiftyCompanions.CursusUser(
				skills: [],
				grade: Optional("Member"),
				level: Optional(12.01),
				blackholedAt: nil,
				beginAt: Optional("2021-04-15T13:31:52.000Z"),
				endAt: nil,
				cursus: swiftyCompanions.Cursus(
					id: Optional(21),
					name: Optional("42cursus"))
			)
		],
		projects_users: [
			swiftyCompanions.ProjectsUser(
				id: Optional(2999352),
				occurrence: Optional(0),
				finalMark: nil,
				status: swiftyCompanions.Status.inProgress,
				validated: nil,
				currentTeamID: nil,
				cursusIds: [21],
				project: swiftyCompanions.Project(
					id: Optional(1395),
					name: Optional("swifty-companion"),
					parentId: nil
				),
				markedAt: nil,
				marked: Optional(false),
				retriableAt: nil,
				createdAt: nil,
				updatedAt: nil
			), swiftyCompanions.ProjectsUser(
				id: Optional(2977423),
				occurrence: Optional(0),
				finalMark: Optional(100),
				status: swiftyCompanions.Status.finished,
				validated: Optional(true),
				currentTeamID: nil,
				cursusIds: [21],
				project: swiftyCompanions.Project(
					id: Optional(1337),
					name: Optional("ft_transcendence"),
					parentId: nil
				),
				markedAt: nil,
				marked: Optional(true),
				retriableAt: nil,
				createdAt: nil,
				updatedAt: nil),
			swiftyCompanions.ProjectsUser(
				id: Optional(2977425),
				occurrence: Optional(1),
				finalMark: Optional(100),
				status: swiftyCompanions.Status.finished,
				validated: Optional(true),
				currentTeamID: nil,
				cursusIds: [21],
				project: swiftyCompanions.Project(
					id: Optional(1324),
					name: Optional("Exam Rank 06"),
					parentId: nil
				),
				markedAt: nil,
				marked: Optional(true),
				retriableAt: nil,
				createdAt: nil,
				updatedAt: nil),
			swiftyCompanions.ProjectsUser(
				id: Optional(2458086),
				occurrence: Optional(1),
				finalMark: Optional(125),
				status: swiftyCompanions.Status.finished,
				validated: Optional(true),
				currentTeamID: nil,
				cursusIds: [21],
				project: swiftyCompanions.Project(
					id: Optional(1335),
					name: Optional("ft_containers"),
					parentId: nil
				),
				markedAt: nil,
				marked: Optional(true),
				retriableAt: nil,
				createdAt: nil,
				updatedAt: nil
			)
		],
		languages_users: [
			swiftyCompanions.LanguagesUser(
				language_id: Optional(6),
				position: Optional(1)),
			swiftyCompanions.LanguagesUser(
				language_id: Optional(2),
				position: Optional(2))],
		campus: [
			swiftyCompanions.Campus(
				name: Optional("Kazan"),
				website: Optional("21-school.ru")
			),
			swiftyCompanions.Campus(
				name: Optional("Wolfsburg"),
				website: Optional("http://42wolfsburg.de/")
			)
		]
	)
	
	static let expectedData : ProfilePageUnitTestsExpectedData = ProfilePageUnitTestsExpectedData(
		userProfileAvatarCellData: UserProfileAvatarCellData(
			loginLabel: "@fcody",
			displayNameLabel: "Dmitrii Grigorev",
			campusLabel: "Wolfsburg",
			locationLabel: "unavailable",
			emailLabel: "fcody@student.42wolfsburg.de",
			displayLabelTextColor: UIColor.CompanionColors.textSecondary
		),
		userProfileLevelCellData: UserProfileLevelCellData(
			levelLabel: "42cursus: level 12.01",
			levelValue: 12.01,
			cursusLabel: "42cursus",
		    levelColor: .yellow
		),
		userProfileBadgeCellData: UserProfileBadgeCellData(badges: [
			swiftyCompanions.Badge(color: UIColor.CompanionColors.green, name: "student"),
			   swiftyCompanions.Badge(color: UIColor.CompanionColors.greenDark, name: "march 2021"),
			   swiftyCompanions.Badge(color: UIColor.CompanionColors.blue, name: "russian"),
			   swiftyCompanions.Badge(color: UIColor.CompanionColors.blue, name: "english"),
			   swiftyCompanions.Badge(color: UIColor.CompanionColors.yellow, name: "1070 wallets")]),
		userProfileProjectsCellData: UserProfileProjectsCellData(projects:[
			swiftyCompanions.UserProfileProjectCellData(
				status: swiftyCompanions.ProjectStatus.inProgress,
				projectNameText: "swifty-companion",
				finalMarkLabelText: "in progress",
				finalMarkLabelBackgroundColor: UIColor.CompanionColors.secondaryBright
			),
			swiftyCompanions.UserProfileProjectCellData(
				status: swiftyCompanions.ProjectStatus.finished(
					value: 100,
					validated: true
				),
				projectNameText: "ft_transcendence",
				finalMarkLabelText: "100",
				finalMarkLabelBackgroundColor: UIColor.CompanionColors.green
			),
			swiftyCompanions.UserProfileProjectCellData(
				status: swiftyCompanions.ProjectStatus.finished(
					value: 100,
					validated: true
				),
				projectNameText: "Exam Rank 06",
				finalMarkLabelText: "100",
				finalMarkLabelBackgroundColor: UIColor.CompanionColors.green
			),
		   swiftyCompanions.UserProfileProjectCellData(
			status: swiftyCompanions.ProjectStatus.finished(
				value: 125,
				validated: true),
			projectNameText: "ft_containers",
			finalMarkLabelText: "125",
			finalMarkLabelBackgroundColor: UIColor.CompanionColors.green
		   ),
		]),
		userProfileGraphsCellData: UserProfileGraphsCellData(
			loginGraphData: GraphData(nameLabel: Optional("Login time last month"), valueTailLabel: Optional("h"), prevOverallValue: Optional(0), currOverallValue: Optional(9), currPointData: Optional([(0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0), (6, 0), (7, 0), (8, 0), (9, 0), (10, 0), (11, 0), (12, 141), (13, 65), (14, 0), (15, 0), (16, 0), (17, 0), (18, 0), (19, 2), (20, 0), (21, 0), (22, 0), (23, 0), (24, 0), (25, 0), (26, 0), (27, 0), (28, 0), (29, 0), (30, 0), (31, 0)])),
			evalsGraphData: GraphData(
				nameLabel: Optional("Evaluations last month"),
				valueTailLabel: Optional(""),
				prevOverallValue: Optional(0),
				currOverallValue: Optional(0),
				currPointData: Optional([
					(0, 0), (1, 0), (2, 0), (3, 0), (4, 0), (5, 0), (6, 0), (7, 0), (8, 0), (9, 0), (10, 0), (11, 0), (12, 0), (13, 0), (14, 0), (15, 0), (16, 0), (17, 0), (18, 0), (19, 0), (20, 0), (21, 0), (22, 0), (23, 0), (24, 0), (25, 0), (26, 0), (27, 0), (28, 0), (29, 0), (30, 0), (31, 0)
				]))
		)
	)
}
