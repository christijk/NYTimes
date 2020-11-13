//
//  Constants.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation

// MARK: Named Closures

typealias Parameters = [String: Any]
typealias NetworkCompletion<T> = (Result<T, NYError>) -> Void
typealias ErrorClosure = (NYError) -> Void
typealias VoidClosure = () -> Void

// MARK: HTTP Methods

enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case patch = "PATCH"
}

// MARK: Constants required for the app

struct Constants {
	static let apiKeyValue = "5763846de30d489aa867f0711e2b031c"
	static let rootURL = URL(string: "https://api.nytimes.com")!
	static let rootImageUrl = URL(string: "https://nytimes.com")!
	static let contentType = "Content-Type"
	static let contentTypeJson = "application/json"
	
}

// MARK: Image names from assets

struct NYImage {
	static let placeHolder = "img-placeholder"
}

// MARK: struct to define storyboard id's

struct StoryboardId {
	static let newsList = "kNewsListViewController"
	static let newsDetails = "kNewsDetailsViewController"
}
