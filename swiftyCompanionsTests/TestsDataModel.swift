//
//  TestsExpectedDataModel.swift
//  swiftyCompanionsTests
//
//  Created by Dmitrii Grigorev on 29.04.23.
//

import Foundation
@testable import swiftyCompanions

struct ProfilePageUnitTestsExpectedData {
	let userProfileAvatarCellData : UserProfileAvatarCellData
	let	userProfileLevelCellData : UserProfileLevelCellData
	let userProfileBadgeCellData : UserProfileBadgeCellData
	let userProfileProjectsCellData : UserProfileProjectsCellData
	let userProfileGraphsCellData : UserProfileGraphsCellData
}

struct ProfilePageUnitTestsData {
	let expectedData : ProfilePageUnitTestsExpectedData
	let sourseData : UserModel
}
