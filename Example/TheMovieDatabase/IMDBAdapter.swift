//
//  IMDBAdapter.swift
//  TheMovieDatabase_Example
//
//  Created by Rubén on 2/11/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import Foundation
import UIKit

import TheMovieDatabase

struct IMDBAdapter: AbstractMovieDatabase {
	
	func searchFor(movieNamed searchQuery: String,
				   completion: @escaping Self.MovieSearchResultsCompletionHandler) {
		
	}
	
	func getImage(atPath path: String,
				  size: CGSize,
				  quality: ImageQuality,
				  completion: @escaping Self.ImageDownloadCompletionHandler) {
		
	}
}
