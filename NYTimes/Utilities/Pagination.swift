//
//  Pagination.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation

// MARK: Base protocol used to fetch paginated data

protocol Pagination {
	var isRequesting: Bool { get }
	var isNextPagePresent: Bool { get }
	var pageIndex: Int { get }
	func getItems()
	func getItemsForNextPage()
	func getItemsForPageNumber(_ page: Int)
}
