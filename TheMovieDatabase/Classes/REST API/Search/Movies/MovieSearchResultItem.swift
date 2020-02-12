//
//  MovieSearchResultItem.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

public struct MovieSearchResultItem: Codable {
	public let originalTitle: String
	public let overview: String
	public let releaseDate: String?
	public let posterPath: String?
	public let id: Int
	let popularity: Double
    let voteCount: Int
    let video: Bool
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case posterPath = "poster_path"
        case id = "id"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title = "title"
        case voteAverage = "vote_average"
        case overview = "overview"
        case releaseDate = "release_date"
    }
}
