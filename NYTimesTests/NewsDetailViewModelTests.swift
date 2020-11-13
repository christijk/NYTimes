//
//  NewsDetailViewModelTests.swift
//  NYTimesTests
//
//  Created by Christi John on 12/11/2020.
//

import XCTest
@testable import NYTimes

class NewsDetailViewModelTests: XCTestCase {

	var sut: NewsDetailViewModel!
	var imageStore: ImageCacheProtocol!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		sut = NewsDetailViewModel(news: mockNews)
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
	
	func testCategoryExists() {
		if let category = sut.category {
			XCTAssertFalse(category.isEmpty)
		} else {
			XCTFail("Failed to fetch category")
		}
	}
	
	func testBylineExists() {
		if let byLine = sut.byLine {
			XCTAssertFalse(byLine.isEmpty)
		} else {
			XCTFail("Failed to fetch byLine")
		}
	}
	
	func testContentExists() {
		if let content = sut.content {
			XCTAssertFalse(content.isEmpty)
		} else {
			XCTFail("Failed to fetch content")
		}
	}
	
	func testDateFormatFailure() {
		var news = mockNews
		news.pubDate = nil
		sut = NewsDetailViewModel(news: news)
		
		let date = sut.date ?? ""
		XCTAssertTrue(date.isEmpty)
	}
	
	func testLargeImageUrlEmpty() {
		var news = mockNews
		news.multimedia = nil
		sut = NewsDetailViewModel(news: news)
		
		let url = sut.imageURL?.absoluteString ?? ""
		XCTAssertTrue(url.isEmpty)
	}
	
	func testFetchLargeImageFailure() {
		var news = mockNews
		news.multimedia = nil
		sut = NewsDetailViewModel(news: news)
		
		let expectation = self.expectation(description: "Large image load failed")
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
	
	func testLargeImageUrlNotEmpty() {
		let url = sut.imageURL?.absoluteString ?? ""
		XCTAssertFalse(url.isEmpty)
	}
	
	func testFetchLargeImageSuccess() {
		let expectation = self.expectation(description: "Large image load success")
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

	func testFetchImage() {
		let expectation = self.expectation(description: "Large image load success")
		
		sut.fetchImage { (image) in
			XCTAssertNotNil(image)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 5.0)
	}
}

private extension NewsDetailViewModelTests {
	var mockNews: News {
		let headLine = Headline(main: "Mock headline")
		let multiMedia = Multimedia(subtype: "xlarge", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-articleLarge-v2.jpg")
		let thumnail = Multimedia(subtype: "thumbnail", url: "images/2020/11/03/world/00Israel-Dubai-Promo/00Israel-Dubai-Promo-thumbStandard-v2.jpg")
		let byLine = ByLine(original: "Mock byline")
		let news = News(leadParagraph: "Mock paragraph", snippet: "Mock snippet", pubDate: "2020-11-07T10:00:22+0000", sectionName: "World", subsectionName: "UAE", headline: headLine, multimedia: [multiMedia, thumnail], byline: byLine)
		return news
	}
}
