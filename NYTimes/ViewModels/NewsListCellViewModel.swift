//
//  NewsListCellViewModel.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation
import UIKit

protocol ImageLoader {
	var imageURL: URL? { get }
	func fetchImage(completion: @escaping (UIImage?) -> Void)
}

protocol NewsListCellViewModelProtocol: ImageLoader, DateFormatterProtocol {
	var title: String? { get }
	var date: String? { get }
	var snippet: String? { get }
	var news: News { get }
}

final class NewsListCellViewModel {
	var news: News
	private let imageStore: ImageCacheProtocol
	
	init(news: News) {
		self.news = news
		self.imageStore = ImageCache()
	}
}

// MARK:- NewsListCellViewModelProtocol Requirements

extension NewsListCellViewModel: NewsListCellViewModelProtocol {
	
	var title: String? {
		return news.headline?.main
	}
	
	var date: String? {
		return formatDate(news.pubDate)
	}
	
	var snippet: String? {
		return news.snippet
	}
	
	var imageURL: URL? {
		return news.thumbImageUrl
	}
	
	// Method to fetch image: either from cache or from server
	// Get the global queue and download image asynchronously
	// Add a barrier flag to ensure thread safety
	//
	func fetchImage(completion: @escaping (UIImage?) -> Void) {
		DispatchQueue.global(qos: .userInitiated).async(flags: .barrier) {
			self.imageStore.imageForUrl(self.imageURL) { (result) in
				switch result {
					case .success(let image):
						completion(image)
					case .failure:
						let placeHolder = UIImage(named: NYImage.placeHolder)
						completion(placeHolder)
				}
			}
		}
	}
}
