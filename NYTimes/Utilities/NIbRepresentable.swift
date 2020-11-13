//
//  NIbRepresentable.swift
//  NYTimes
//
//  Created by Christi John on 12/11/2020.
//

import Foundation
import UIKit

protocol NibRepresentable {
	static var nib: UINib { get }
	static var identifier: String { get }
}

extension UIView: NibRepresentable {
	class var nib: UINib {
		return UINib(nibName: identifier, bundle: nil)
	}
	
	class var identifier: String {
		return String(describing: self)
	}
}
