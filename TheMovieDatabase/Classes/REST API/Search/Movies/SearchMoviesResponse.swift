//
//  SearchMoviesResponse.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

// MARK: - SearchMoviesResponse
internal struct SearchMoviesResponse: Codable {
	
	/// The current page of results
	let page: Int?
	
	/// The total number of movies found
	let totalResults: Int?
	
	/// The number of pages of results
	let totalPages: Int?
	
	/// The results of the movie search query
	let results: [MovieSearchResultItem]?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

