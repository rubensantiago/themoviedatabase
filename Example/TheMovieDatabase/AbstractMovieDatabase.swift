//
//  MovieDatabase.swift
//  TheMovieDatabase_Example
//
//  Created by Rubén on 2/11/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import Foundation
import UIKit
import TheMovieDatabase

protocol AbstractMovieDatabase {
	
	typealias MovieSearchResultsCompletionHandler = ([MovieSearchResultItem]) -> Void
	
	typealias ImageDownloadCompletionHandler = (UIImage?) -> Void
	
	func searchFor(movieNamed searchQuery: String,
				   completion: @escaping MovieSearchResultsCompletionHandler)
	
	func getImage(atPath path: String,
				  size: CGSize,
				  quality: ImageQuality,
				  completion: @escaping ImageDownloadCompletionHandler)
}
