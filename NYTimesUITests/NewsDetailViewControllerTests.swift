//
//  NewsDetailViewControllerTests.swift
//  NYTimesUITests
//
//  Created by Christi John on 12/11/2020.
//

import XCTest

class NewsDetailViewControllerTests: XCTestCase {
	
	let app = XCUIApplication()
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
		app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailView() {
		sleep(12)
		let table = app.tables["NewsListTableView"]
		table.children(matching: .cell).element(boundBy: 0).tap()
		XCTAssertTrue(app.staticTexts["CategoryLabel"].exists)
		XCTAssertTrue(app.staticTexts["TitleLabel"].exists)
		XCTAssertTrue(app.images["LargeImage"].exists)
    }

	func testNavigationBack() {
		sleep(12)
		let table = app.tables["NewsListTableView"]
		table.children(matching: .cell).element(boundBy: 0).tap()
		app.navigationBars["NYTimes"].buttons["NYTimes"].tap()
		let newsListVC = app.otherElements["NewsListVC"]
		let vcShown = newsListVC.waitForExistence(timeout: 5)
		XCTAssert(vcShown)
	}
	
}
