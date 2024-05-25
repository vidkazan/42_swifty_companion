//
//  swiftyCompanionsTests.swift
//  swiftyCompanionsTests
//
//  Created by Dmitrii Grigorev on 29.04.23.
//

import XCTest
@testable import swiftyCompanions

class ProfilePageViewModelTestsByLoginFcody: XCTestCase {
	
	private var sourceData : UserModel!
	private var expectedData : ProfilePageUnitTestsExpectedData!
	private var userProfileViewModel : UserProfileViewControllerViewModel!
	private var loginGraphSourceDataMonthPrevious : [LoginSession]!
	private var loginGraphSourceDataMonthBeforePrevious : [LoginSession]!
	private var evalGraphSourceDataMonthPrevious : [ScaleTeam]!
	private var evalGraphSourceDataMonthBeforePrevious : [ScaleTeam]!
	
	override func setUpWithError() throws {
		self.sourceData = GetUserResultsLoginFcody.sourceData
		
		self.loginGraphSourceDataMonthPrevious = GetUserResultsLoginFcody.loginGraphSourceDataMonthPrevious
		self.loginGraphSourceDataMonthBeforePrevious = GetUserResultsLoginFcody.loginGraphSourceDataMonthBeforePrevious
		
		self.evalGraphSourceDataMonthPrevious = GetUserResultsLoginFcody.evalGraphSourceDataMonthPrevious
		self.evalGraphSourceDataMonthBeforePrevious = GetUserResultsLoginFcody.evalsGraphSourceDataMonthBeforePrevious
		
		self.expectedData = GetUserResultsLoginFcody.expectedData
		self.userProfileViewModel = UserProfileViewControllerViewModel(self.sourceData, requestsGgroupIdentifier: "", searchVM: nil)
	 }
	
	func testAvatarCell() {
		let expectation = self.expectation(description: "Avater Cell ViewModel")
		let actual = self.userProfileViewModel.getAvatarCellData()
		let expected = self.expectedData.userProfileAvatarCellData
		
		
		XCTAssertEqual(actual.loginLabel, expected.loginLabel )
		XCTAssertEqual(actual.campusLabel, expected.campusLabel )
		XCTAssertEqual(actual.displayNameLabel,expected.displayNameLabel )
		XCTAssertEqual(actual.emailLabel, expected.emailLabel)
		XCTAssertEqual(actual.locationLabel, expected.locationLabel)
		XCTAssertEqual(actual.displayLabelTextColor, expected.displayLabelTextColor)
		
		expectation.fulfill()
		self.waitForExpectations(timeout: 1, handler: nil)
    }
	
	func testLevelCell() {
		let expectation = self.expectation(description: "Level Cell ViewModel")
		let actual = self.userProfileViewModel.getLevelCellData()
		let expected = self.expectedData.userProfileLevelCellData
		
		XCTAssertEqual(actual.cursusLabel, expected.cursusLabel)
		XCTAssertEqual(actual.levelLabel, expected.levelLabel)
		XCTAssertEqual(actual.levelValue, expected.levelValue)
		
		
		expectation.fulfill()
		self.waitForExpectations(timeout: 1, handler: nil)
	}
	
	func testBadgeCell() {
		let expectation = self.expectation(description: "Badge Cell ViewModel")
		let actual = self.userProfileViewModel.getBadgeCellData()
		let expected = self.expectedData.userProfileBadgeCellData
		
		XCTAssertEqual(actual,expected)
		expectation.fulfill()
		self.waitForExpectations(timeout: 1, handler: nil)
	}
		
	func testProjectsCell() {
		let expectation = self.expectation(description: "Projects Cell ViewModel")
		let actual = self.userProfileViewModel.getProjectsCellData()
		let expected = self.expectedData.userProfileProjectsCellData
		
		XCTAssertEqual(actual,expected)
		expectation.fulfill()
		self.waitForExpectations(timeout: 1, handler: nil)
	}
	
	func graphDataPointsComparing(_ lhs : GraphData,_ rhs: GraphData) -> Bool {
		guard let lhsPoints = lhs.currPointData, let rhsPoints = rhs.currPointData else {
			return true
		}
		if lhsPoints.count != rhsPoints.count {
			print("count not equal")
			return false
		}
		print(lhsPoints)
		print(rhsPoints)
		for i in 0..<lhsPoints.count {
			if lhsPoints[i] != rhsPoints[i] {
				return false
			}
		}
		return true
		
	}
}
