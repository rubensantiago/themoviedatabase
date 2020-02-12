//
//  TheMovieDatabaseAdapter.swift
//  TheMovieDatabase_Example
//
//  Created by Rubén on 2/11/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import Foundation
import TheMovieDatabase

struct TheMovieDatabaseAdapter: AbstractMovieDatabase {
	
	let movieDB = TheMovieDatabase()
	
	func searchFor(movieNamed searchQuery: String,
				   completion: @escaping Self.MovieSearchResultsCompletionHandler) {
		
		movieDB.searchFor(movieNamed: searchQuery) { (searchResults) in
			completion(searchResults)
		}
	}
	
	func getImage(atPath path: String,
				  size: CGSize = CGSize(width: 600, height: 900),
				  quality: ImageQuality = .best,
				  completion: @escaping Self.ImageDownloadCompletionHandler) {
		
		movieDB.getImage(atPath: path) { (moviePoster) in
			completion(moviePoster)
		}
	}
}
