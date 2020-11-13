//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Christi John on 11/11/2020.
//

import XCTest
@testable import NYTimes

class NewsListViewModelTests: XCTestCase {

	var sut: NewsListViewModel!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		sut = NewsListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testAddToNewsListCellModels() {
		XCTAssertEqual(sut.numberOfRows, 0)
		let viewModel = NewsListCellViewModel(news: mockNews)
		sut.addToNewsListCellModels(viewModel)
		XCTAssertEqual(sut.numberOfRows, 1)
		
		sut.addToNewsListCellModels(viewModel)
		sut.addToNewsListCellModels(viewModel)
		XCTAssertEqual(sut.numberOfRows, 3)
	}
	
	func testGetNewsListCellModel() {
		let viewModel = sut.getNewsListCellModel(for: 0)
		XCTAssertNil(viewModel)
		
		let viewModel1 = NewsListCellViewModel(news: mockNews)
		sut.addToNewsListCellModels(viewModel1)
		XCTAssertNotNil(sut.getNewsListCellModel(for: 0))
	}
	
	func testGetItemsAPISucess() {
		let expectation = self.expectation(description: "Newslist fetching")
		
		sut.onAPISuccess = { [weak self] in
			XCTAssertNotNil(self?.sut.getNewsListCellModel(for: 0))
			XCTAssertEqual(self?.sut.pageIndex, 0)
			XCTAssertEqual(self?.sut.numberOfRows, 10)
			expectation.fulfill()
		}
		
		sut.getItems()
		wait(for: [expectation], timeout: 10.0)
	}
	
	func testGetItemsAPIFailure() {
		let expectation = self.expectation(description: "Newslist fetching")
		
		sut.onAPIError = { [weak self] error in
			XCTAssertNotNil(error)
			XCTAssertEqual(error.title, "Oops")
			XCTAssertEqual(error.errorDescription, "Something went wrong!")
			XCTAssertEqual(self?.sut.pageIndex, 201)
			XCTAssertEqual(self?.sut.numberOfRows, 0)
			expectation.fulfill()
		}
		
		sut.getItemsForPageNumber(201)
		wait(for: [expectation], timeout: 5.0)
	}
	
	func testGetItemsLoding() {
		XCTAssertFalse(sut.isRequesting)
		
		let expectation = self.expectation(description: "Newslist fetching")
		
		sut.onAPISuccess = { [weak self] in
			guard let strongSelf = self else { return }
			XCTAssertFalse(strongSelf.sut.isRequesting)
			expectation.fulfill()
		}
		
		sut.getItems()
		XCTAssertEqual(sut.pageIndex, 0)
		wait(for: [expectation], timeout: 15.0)
	}

	func testGetItemsForNextPage() {
		let firstPageExpectation = self.expectation(description: "Newslist fetching")
		
		sut.onAPISuccess = { [weak self] in
			XCTAssertEqual(self?.sut.pageIndex, 0)
			XCTAssertEqual(self?.sut.numberOfRows, 10)
			firstPageExpectation.fulfill()
		}
		
		sut.getItems()
		wait(for: [firstPageExpectation], timeout: 15.0)
		
		let secondPageExpectation = self.expectation(description: "Newslist fetching")
		
		sut.onAPISuccess = { [weak self] in
			XCTAssertEqual(self?.sut.pageIndex, 1)
			XCTAssertEqual(self?.sut.numberOfRows, 20)
			secondPageExpectation.fulfill()
		}
		
		sut.getItemsForNextPage()
		wait(for: [secondPageExpectation], timeout: 15.0)
	}
}

private extension NewsListViewModelTests {
	var mockNews: News {
		let headLine = Headline(main: "Its Like Falling in Love’: Israeli Entrepreneurs Welcomed in Dubai")
		let multiMedia = Multimedia(subtype: "xlarge", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-articleLarge-v2.jpg")
		let byLine = ByLine(original: "By Isabel Kershner and Photographs by Dan Balilty")
		let news = News(leadParagraph: "DUBAI — For years, Israeli entrepreneurs slipped in and out of the United Arab Emirates incognito, traveling on second passports or doing business through third parties.", snippet: "A high-profile delegation of Israeli innovators visited the United Arab Emirates soon after moves to normalize relations.", pubDate: "2020-11-07T10:00:22+0000", sectionName: "World", subsectionName: "Middle East", headline: headLine, multimedia: [multiMedia], byline: byLine)
		return news
	}
}
