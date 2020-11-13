//
//  NewsListViewControllerTests.swift
//  NYTimesTests
//
//  Created by Christi John on 12/11/2020.
//

import XCTest
@testable import NYTimes

class NewsListViewControllerTests: XCTestCase {

	var sut: NewsListViewController!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(withIdentifier: "kNewsListViewController") as? NewsListViewController
		sut.viewModel = NewsListViewModel()
		sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testNumberOfRows() {
		let newsListCellViewModel = NewsListCellViewModel(news: mockNews)
		sut.viewModel.addToNewsListCellModels(newsListCellViewModel)
		sut.viewModel.addToNewsListCellModels(newsListCellViewModel)
		
		let cells = sut.tableView.numberOfRows(inSection: 0)
		XCTAssertEqual(cells, 2)
	}

	func testLoadNextPage() {
		let vm = NewsListCellViewModel(news: mockNews)
		let newsListCellViewModelArray = [vm, vm, vm, vm, vm, vm, vm, vm]
		for model in newsListCellViewModelArray {
			sut.viewModel.addToNewsListCellModels(model)
		}

		sut.tableView.scrollToRow(at: IndexPath(row: 7, section: 0), at: .bottom, animated: false)
		XCTAssertTrue(sut.viewModel.isRequesting)
	}
}

private extension NewsListViewControllerTests {
	var mockNews: News {
		let headLine = Headline(main: "Mock headline")
		let multiMedia = Multimedia(subtype: "xlarge", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-articleLarge-v2.jpg")
		let thumnail = Multimedia(subtype: "thumbnail", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-thumbStandard-v2.jpg")
		let byLine = ByLine(original: "Mock byline")
		let news = News(leadParagraph: "Mock paragraph", snippet: "Mock snippet", pubDate: "2020-11-07T10:00:22+0000", sectionName: "World", subsectionName: "UAE", headline: headLine, multimedia: [multiMedia, thumnail], byline: byLine)
		return news
	}
}
