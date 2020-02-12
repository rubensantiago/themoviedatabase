//
//  SearchMoviesResponse.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

// MARK: - SearchMoviesResponse
internal struct SearchMoviesResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MovieSearchResultItem]

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

