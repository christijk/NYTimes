//
//  NewsListRequestHandler.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation
import UIKit

protocol NewsListRequestHandlerProtocol {
	func getNewsListing(_ pageIndex: Int, completion: @escaping NetworkCompletion<NewsList>)
}

final class NewsListRequestHandler: NewsListRequestHandlerProtocol {
	/// Method to get all the news for a paga
	///
	/// - Parameter pageIndex: Int value of required page
	/// - Parameter completion: Closure with news list items
	///
	func getNewsListing(_ pageIndex: Int, completion: @escaping NetworkCompletion<NewsList>) {
		let router = NewsListAPIRouter.newsList(pageIndex)
		NetworkManager.request(route: router, completion: completion)
	}
}


