//
//  DateFormatterProtocol.swift
//  NYTimes
//
//  Created by Christi John on 12/11/2020.
//

import Foundation

protocol DateFormatterProtocol { }

extension DateFormatterProtocol {
	func formatDate(_ date: String?) -> String? {
		guard let date = date else { return nil }
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
		guard let outputDate = dateFormatter.date(from: date) else {
			return nil
		}
		dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
		return dateFormatter.string(from: outputDate)
	}
}
