//
//  ImageCache.swift
//  NYTimes
//
//  Created by Christi John on 12/11/2020.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
	func imageForUrl(_ url: URL?,
					 completion: @escaping (Result<UIImage, NYError>) -> Void)
}

// MARK: Cache to store images

final class ImageCache: ImageCacheProtocol {
	private let imageCache = NSCache<NSString, UIImage>()

	/// Method to fetch image either from cache or from url
	///
	/// - Parameter url: Key used to get the image
	/// - Parameter completion: Closure which contains the image or error
	///
	func imageForUrl(_ url: URL?,
					 completion: @escaping (Result<UIImage, NYError>) -> Void) {
		guard let url = url else {
			completion(.failure(.imageLoadFailed))
			return
		}
		
		// Check image from cache store first.
		// If not found, get it from api
		//
		if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
			completion(.success(cachedImage))
		} else {
			URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
				if let _ = error {
					completion(.failure(.imageLoadFailed))
				} else if let data = data,
						  let image = UIImage(data: data) {
					self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
					completion(.success(image))
				} else {
					completion(.failure(.imageLoadFailed))
				}
			}.resume()
		}		
	}
}
