//
//  NewsListViewModel.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation

protocol NewsListViewModelProtocol: Pagination {
	var onAPIError: ErrorClosure?  { get set }
	var onAPISuccess: VoidClosure?  { get set }
	var numberOfRows: Int { get }
	var newsListCellModels: [NewsListCellViewModelProtocol] { get }
	func addToNewsListCellModels(_ vm: NewsListCellViewModelProtocol)
	func getNewsListCellModel(for indexPath: Int) -> NewsListCellViewModelProtocol?
	
}

final class NewsListViewModel: NewsListViewModelProtocol {
	var onAPIError: ErrorClosure?
	var onAPISuccess: VoidClosure?
	private(set) var isRequesting: Bool
	private(set) var pageIndex: Int
	private(set) var newsListCellModels: [NewsListCellViewModelProtocol]
	private let newsListRequestHandler: NewsListRequestHandlerProtocol
	private let totalPages: Int
	
	var numberOfRows: Int {
		return newsListCellModels.count
	}
	
	init() {
		self.isRequesting = false
		self.pageIndex = 0
		self.newsListCellModels = []
		self.newsListRequestHandler = NewsListRequestHandler()
		self.totalPages = 200
	}
	
	func addToNewsListCellModels(_ vm: NewsListCellViewModelProtocol) {
		newsListCellModels.append(vm)
	}
	
	func getNewsListCellModel(for indexPath: Int) -> NewsListCellViewModelProtocol? {
		return newsListCellModels[safe: indexPath]
	}
}

// MARK:- Pagination protocol requirements

extension NewsListViewModel: Pagination {
	var isNextPagePresent: Bool {
		return (pageIndex<totalPages)
	}
	
	func getItems() {
		DispatchQueue.global().async {
			self.getNewsList(for: self.pageIndex)
		}
	}
	
	func getItemsForNextPage() {
		DispatchQueue.global().async {
			self.getNewsList(for: self.pageIndex + 1)
		}
	}
	
	func getItemsForPageNumber(_ page: Int) {
		DispatchQueue.global().async {
			self.getNewsList(for: page)
		}
	}
}

// MARK:- Private Methods

private extension NewsListViewModel {
	/// Call to get news list for a page from server
	///
	/// - Parameter page: index of required page
	///
	func getNewsList(for page: Int) {
		guard !isRequesting else {
			return
		}
		isRequesting = true
		pageIndex = page
		newsListRequestHandler.getNewsListing(page) { [weak self] (result) in
			self?.isRequesting = false
			switch result {
				case .success(let newsList):
					self?.handleAPISucess(newsList)
				case .failure(let error):
					self?.handleAPIFailure(error)
			}
		}
	}
	
	// Inform the view controller about API success,
	// through closures, so vc can reload table
	//
	func handleAPISucess(_ newsList: NewsList) {
		let cellModels = newsList.items.map { NewsListCellViewModel(news: $0) }
		for vm in cellModels {
			addToNewsListCellModels(vm)
		}
		onAPISuccess?()
	}
	
	// Inform the vc about API failure using closure
	// so vc can stop loading and show error message
	//
	func handleAPIFailure(_ error: NYError) {
		onAPIError?(error)
	}
}
