//
//  NewsListAPIRouter.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation

// MARK: Enum for news list api calls

enum NewsListAPIRouter {
	private struct Path {
		static let newsList = "/svc/search/v2/articlesearch.json"
	}
	
	case newsList(_ pageIndex: Int)
	
	var path: String {
		switch self {
			case .newsList:
				return Path.newsList
		}
	}
}

// MARK: - APIRouter Protocol requirements

extension NewsListAPIRouter: APIRouter {
	var requestURL: URL {
		switch self {
			case .newsList:
				return Constants.rootURL.appendingPathComponent(path)
		}
	}
	
	var method: HTTPMethod {
		switch self {
			case .newsList:
				return .get
		}
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	var parameters: Parameters? {
		switch self {
			case .newsList(let pageIndex):
				return [Constants.apiKey: Constants.apiKeyValue,
						Constants.query: Constants.dubai,
						Constants.page: String(pageIndex)]
			
		}
	}
}

extension Constants {
	static let apiKey = "api-key"
	static let query = "q"
	static let dubai = "singapore"
	static let page = "page"
}
