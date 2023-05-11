//
//  swiftyCompanionsUITests.swift
//  swiftyCompanionsUITests
//
//  Created by Dmitrii Grigorev on 29.04.23.
//

import XCTest

class swiftyCompanionsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testExample() throws {
		
		let app = XCUIApplication()
		app.launch()
		
		let navBar = app.navigationBars["Search 42 Users"]
		XCTAssertTrue(navBar.exists)
		
		let searchSearchField = navBar.searchFields["Search"]
		XCTAssertTrue(searchSearchField.exists)
		
		searchSearchField.tap()
		searchSearchField.typeText("fcody")
		
		sleep(2)
		
		app.collectionViews.cells.containing(.staticText, identifier: "@fcody").element.tap()
		
		sleep(1)
		
		
		let collectionViewsQuery = app.collectionViews
		collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Wolfsburg | unavailable"]/*[[".cells.staticTexts[\"Wolfsburg | unavailable\"]",".staticTexts[\"Wolfsburg | unavailable\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Dmitrii Grigorev"]/*[[".cells.staticTexts[\"Dmitrii Grigorev\"]",".staticTexts[\"Dmitrii Grigorev\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["fcody@student.42wolfsburg.de"]/*[[".cells.staticTexts[\"fcody@student.42wolfsburg.de\"]",".staticTexts[\"fcody@student.42wolfsburg.de\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["42cursus: level 12.01"]/*[[".cells.staticTexts[\"42cursus: level 12.01\"]",".staticTexts[\"42cursus: level 12.01\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["student"]/*[[".cells.collectionViews",".cells.staticTexts[\"student\"]",".staticTexts[\"student\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["march 2021"]/*[[".cells.collectionViews",".cells.staticTexts[\"march 2021\"]",".staticTexts[\"march 2021\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["russian"]/*[[".cells.collectionViews",".cells.staticTexts[\"russian\"]",".staticTexts[\"russian\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["english"]/*[[".cells.collectionViews",".cells.staticTexts[\"english\"]",".staticTexts[\"english\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["1070 wallets"]/*[[".cells.collectionViews",".cells.staticTexts[\"1070 wallets\"]",".staticTexts[\"1070 wallets\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
		
		let inProgressStaticText = collectionViewsQuery/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["in progress"]/*[[".cells.collectionViews",".cells.staticTexts[\"in progress\"]",".staticTexts[\"in progress\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
		inProgressStaticText.tap()
		
		let collectionViewsQuery2 = collectionViewsQuery.cells.collectionViews
		collectionViewsQuery2.cells.containing(.staticText, identifier:"ft_transcendence").staticTexts["100"].tap()
		collectionViewsQuery2.cells.containing(.staticText, identifier:"Exam Rank 06").staticTexts["100"].swipeLeft()
		inProgressStaticText.swipeLeft()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["9h"]/*[[".cells.staticTexts[\"9h\"]",".staticTexts[\"9h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["▲9"]/*[[".cells.staticTexts[\"▲9\"]",".staticTexts[\"▲9\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
				
				
		
		
//		app.
				
//		let searchSearchField = app.navigationBars["Search 42 Users"].searchFields["Search"].tap()
		
		
		        // UI tests must launch the application that they test.
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
	
