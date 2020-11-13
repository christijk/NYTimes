//
//  News.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation

protocol MultiMediaRepresenatable {
	var thumbImageUrl: URL? { get }
	var largeImageUrl: URL? { get }
}

struct News: Codable {
	var leadParagraph: String?
	var snippet: String?
	var pubDate: String?
	var sectionName: String?
	var subsectionName: String?
	var headline: Headline?
	var multimedia: [Multimedia]?
	var byline: ByLine?
}

struct Headline: Codable {
	var main: String?
}

struct Multimedia: Codable {
	var subtype: String?
	var url: String?
}

struct ByLine: Codable {
	var original: String?
}

extension News: MultiMediaRepresenatable {
	var thumbImageUrl: URL? {
		let media = multimedia?.filter{$0.subtype == "thumbnail"}.first
		guard let url = media?.url else {
			return nil
		}
		return Constants.rootImageUrl.appendingPathComponent(url)
	}
	
	var largeImageUrl: URL? {
		let media = multimedia?.filter{$0.subtype == "xlarge"}.first
		guard let url = media?.url else {
			return nil
		}
		return Constants.rootImageUrl.appendingPathComponent(url)
	}
}
