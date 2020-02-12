//
//  MovieSearchResultItem.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

public struct MovieSearchResultItem: Codable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    public let posterPath: String?
    public let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: OriginalLanguage
    public let originalTitle: String
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    public let overview: String
    public let releaseDate: String

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
