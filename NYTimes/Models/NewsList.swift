//
//  NewsList.swift
//  NYTimes
//
//  Created by Christi John on 11/11/2020.
//

import Foundation

struct NewsList: Codable {
	var items: [News] = []
	
	enum CodingKeys: String, CodingKey {
		case response = "response"
		case docs = "docs"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
		items = try response.decodeIfPresent([News].self, forKey: .docs) ?? []
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
		try response.encode(items, forKey: .docs)
	}
}
