//
//  NewsListCellViewModel.swift
//  NYTimesTests
//
//  Created by Christi John on 12/11/2020.
//

import XCTest
@testable import NYTimes

class NewsListCellViewModelTests: XCTestCase {

	var sut: NewsListCellViewModel!
	var imageStore: ImageCacheProtocol!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		sut = NewsListCellViewModel(news: mockNews)
		imageStore = ImageCache()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testTitleExists() {
		if let title = sut.title {
			XCTAssertFalse(title.isEmpty)
		} else {
			XCTFail("Failed to fetch title.")
		}
	}
	
	func testSnippetExists() {
		if let snippet = sut.snippet {
			XCTAssertFalse(snippet.isEmpty)
		} else {
			XCTFail("Failed to fetch snippet")
		}
	}
	
	func testDateExists() {
		if let date = sut.date {
			XCTAssertFalse(date.isEmpty)
		} else {
			XCTFail("Failed to fetch date")
		}
	}

	func testThumbnailImageUrlEmpty() {
		var news = mockNews
		news.multimedia = nil
		sut = NewsListCellViewModel(news: news)
		
		let url = sut.imageURL?.absoluteString ?? ""
		XCTAssertTrue(url.isEmpty)
	}
	
	
	func testFetchThumbnailImageFailure() {
		var news = mockNews
		news.multimedia = nil
		sut = NewsListCellViewModel(news: news)
		
		let expectation = self.expectation(description: "Thumnail image load failed")
		imageStore.imageForUrl(sut.imageURL) { (result) in
			switch result {
				case .success(let image):
					XCTAssertNil(image)
				case .failure(let error):
					XCTAssertNotNil(error)
					XCTAssertEqual(error.title, "No image found")
					XCTAssertEqual(error.errorDescription, "Something went wrong!")
					expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 5.0)
	}
	
	func testThumnailImageUrlNotEmpty() {
		let url = sut.imageURL?.absoluteString ?? ""
		XCTAssertFalse(url.isEmpty)
	}
	
	func testFetchThumnailImageSuccess() {
		let expectation = self.expectation(description: "Thumnail image load success")
		imageStore.imageForUrl(sut.imageURL) { (result) in
			switch result {
				case .success(let image):
					XCTAssertNotNil(image)
					expectation.fulfill()
				case .failure(let error):
					XCTAssertNil(error)
			}
		}
		wait(for: [expectation], timeout: 5.0)
	}
	
	func testFetchImageFromCache() {
		let expectation = self.expectation(description: "Thumnail image load success")
		imageStore.imageForUrl(sut.imageURL) { (result) in
			switch result {
				case .success(let image):
					XCTAssertNotNil(image)
					expectation.fulfill()
				case .failure(let error):
					XCTAssertNil(error)
			}
		}
		wait(for: [expectation], timeout: 5.0)
		
		let cacheExpectation = self.expectation(description: "Thumnail from cache")
		imageStore.imageForUrl(sut.imageURL) { (result) in
			switch result {
				case .success(let image):
					XCTAssertNotNil(image)
					cacheExpectation.fulfill()
				case .failure(let error):
					XCTAssertNil(error)
			}
		}
		wait(for: [cacheExpectation], timeout: 0.1)
	}
	
	func testFetchImage() {
		let expectation = self.expectation(description: "Thumnail image load success")
		
		sut.fetchImage { (image) in
			XCTAssertNotNil(image)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 5.0)
	}
}

private extension NewsListCellViewModelTests {
	var mockNews: News {
		let headLine = Headline(main: "Mock headline")
		let multiMedia = Multimedia(subtype: "xlarge", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-articleLarge-v2.jpg")
		let thumnail = Multimedia(subtype: "thumbnail", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-thumbStandard-v2.jpg")
		let byLine = ByLine(original: "Mock byline")
		let news = News(leadParagraph: "Mock paragraph", snippet: "Mock snippet", pubDate: "2020-11-07T10:00:22+0000", sectionName: "World", subsectionName: "UAE", headline: headLine, multimedia: [multiMedia, thumnail], byline: byLine)
		return news
	}
}
