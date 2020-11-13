//
//  NewsDetailViewModel.swift
//  NYTimes
//
//  Created by Christi John on 12/11/2020.
//

import Foundation
import UIKit

protocol NewsDetailViewModelProtocol: NewsListCellViewModelProtocol {
	var content: String? { get }
	var category: String? { get }
	var byLine: String? { get }
}

final class NewsDetailViewModel {
	var news: News
	private let imageStore: ImageCacheProtocol
	
	init(news: News) {
		self.news = news
		self.imageStore = ImageCache()
	}
}

// MARK:- NewsDetailViewModelProtocol Requirements

extension NewsDetailViewModel: NewsDetailViewModelProtocol {
	
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
		return news.largeImageUrl
	}
	
	var content: String? {
		return news.leadParagraph
	}
	
	var category: String? {
		return news.sectionName
	}
	
	var byLine: String? {
		return news.byline?.original
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
