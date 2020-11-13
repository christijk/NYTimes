//
//  NYError.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation

enum NYError: Error {
	case parameterEncodingFailed
	case invalidURL
	case defaultError
	case imageLoadFailed
	
	var title: String {
		switch self {
			case .parameterEncodingFailed:
				return "Encoding Failed"
			case .invalidURL:
				return "Invalid URL"
			case .imageLoadFailed:
				return "No image found"
			default:
				return "Oops"
		}
	}
	
	var errorDescription: String {
		switch self {
			case .parameterEncodingFailed:
				return "Request parameter encoding failed"
			case .invalidURL:
				return "Unable to create request URL"
			default:
				return "Something went wrong!"
		}
	}
}
