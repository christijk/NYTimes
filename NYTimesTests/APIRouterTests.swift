//
//  APIRouterTests.swift
//  NYTimesTests
//
//  Created by Christi John on 12/11/2020.
//

import XCTest
@testable import NYTimes

class APIRouterTests: XCTestCase {

	var sut: NewsListAPIRouter!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testNewsListMethod() {
		sut = .newsList(0)
		XCTAssertEqual(sut.method, .get)
	}

	func testAPIKey() {
		sut = .newsList(0)
		if let byLine = sut.parameters?["api-key"] as? String {
			XCTAssertFalse(byLine.isEmpty)
		} else {
			XCTFail("Failed to fetch api key")
		}
	}
}
