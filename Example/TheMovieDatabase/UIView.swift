//
//  UIView.swift
//  TheMovieDatabase_Example
//
//  Created by Rubén on 2/11/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	func maskWithRoundedCorners(radius: CGFloat) {
		self.layer.cornerRadius = radius
		self.clipsToBounds = true
	}
}
