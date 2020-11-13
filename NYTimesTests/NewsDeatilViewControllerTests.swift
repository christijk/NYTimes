//
//  NewsDeatilViewControllerTests.swift
//  NYTimesTests
//
//  Created by Christi John on 12/11/2020.
//

import XCTest
@testable import NYTimes

class NewsDeatilViewControllerTests: XCTestCase {

	var sut: NewsDetailsViewController!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(withIdentifier: "kNewsDetailsViewController") as? NewsDetailsViewController
		sut.viewModel = NewsDetailViewModel(news: mockNews)
		sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testViewModelBinding() {
		XCTAssertEqual(sut.categoryLabel.text, sut.viewModel?.category)
		XCTAssertEqual(sut.titleLabel.text, sut.viewModel?.title)
		XCTAssertEqual(sut.dateLabel.text, sut.viewModel?.date)
		XCTAssertEqual(sut.byLabel.text, sut.viewModel?.byLine)
		XCTAssertEqual(sut.snippetlabel.text, sut.viewModel?.snippet)
		XCTAssertEqual(sut.contentLabel.text, sut.viewModel?.content)
	}
}

private extension NewsDeatilViewControllerTests {
	var mockNews: News {
		let headLine = Headline(main: "Mock headline")
		let multiMedia = Multimedia(subtype: "xlarge", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-articleLarge-v2.jpg")
		let thumnail = Multimedia(subtype: "thumbnail", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-thumbStandard-v2.jpg")
		let byLine = ByLine(original: "Mock byline")
		let news = News(leadParagraph: "Mock paragraph", snippet: "Mock snippet", pubDate: "2020-11-07T10:00:22+0000", sectionName: "World", subsectionName: "UAE", headline: headLine, multimedia: [multiMedia, thumnail], byline: byLine)
		return news
	}
}
