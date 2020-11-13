//
//  NewsListCellViewModel.swift
//  NYTimesTests
//
//  Created by Christi John on 12/11/2020.
//

import XCTest
@testable import NYTimes

class NewsListCellViewModelTests: XCTestCase {

	var sut: NewsListCellViewModelTests!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		sut = NewsListCellViewModelTests()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testNewsListCellViewModel() {
		let viewModel = sut.
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

private extension NewsListCellViewModelTests {
	func mockNewsItem() -> News {
		let headLine = Headline(main: "Mock headline")
		let multiMedia = Multimedia(subtype: "xlarge", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-articleLarge-v2.jpg")
		let byLine = ByLine(original: "Mock byline")
		let news = News(leadParagraph: "Mock paragraph", snippet: "Mock snippet", pubDate: "2020-11-07T10:00:22+0000", sectionName: "World", subsectionName: "UAE", headline: headLine, multimedia: [multiMedia], byline: byLine)
		return news
	}
}
