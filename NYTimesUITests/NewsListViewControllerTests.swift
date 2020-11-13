//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Christi John on 11/11/2020.
//

import XCTest

class NewsListViewControllerTests: XCTestCase {
	let app = XCUIApplication()
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
		app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableExists() {
        // UI tests must launch the application that they test.
		let table = app.tables["NewsListTableView"]
		XCTAssertTrue(table.exists)
    }
	
	func testActivityIndicatorExists() {
		let table = app.tables["NewsListTableView"]
		let activity = table.descendants(matching: .activityIndicator).element(boundBy: 0)
		XCTAssertTrue(activity.exists)
		let value = activity.value as? String
		XCTAssertEqual(value, "1")
	}
	
	func testCellExists() {
		sleep(5) // Wait for the api call
		let table = app.tables["NewsListTableView"]
		let cell = table.children(matching: .cell).element(boundBy: 0)
		XCTAssertTrue(cell.exists)
		
		let image = cell.children(matching: .image).element(boundBy: 0)
		XCTAssertTrue(image.exists)
	}

	func testNavigation() {
		let table = app.tables["NewsListTableView"]
		let cell = table.children(matching: .cell).element(boundBy: 0)
		cell.tap()
		
		let newsDeatilsVC = app.otherElements["NewsDetailsVC"]
		let vcShown = newsDeatilsVC.waitForExistence(timeout: 5)
		XCTAssert(vcShown)
	}
}
