//
//  MovieSearchResultItem.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation


/// Represents an individual movie listing from _themoviedb.org_
public struct MovieSearchResultItem: Codable {
	
	/// The original title
	public let originalTitle: String
	
	/// The description
	public let overview: String
	
	/// The release year
	public let releaseDate: String?
	
	/// The path where the poster image can be found
	public let posterPath: String?
	
	/// The unique ID for the movie
	public let id: Int
	
	/// The popularity of a movie
	let popularity: Double
	
	/// The number of votes for a movie
	let voteCount: Int
	
	/// ??
	let video: Bool
	
	/// Path to a backdrop image
	let backdropPath: String?
	
	/// The original language of a movie
	let originalLanguage: String
	
	/// The IDs for the genres of a movie
	let genreIDS: [Int]
	
	/// The title of a movie
	let title: String
	
	/// The average rating
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
        case voteCount = "vote_count"
        case video = "video"
        case posterPath = "poster_path"
        case id = "id"
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
