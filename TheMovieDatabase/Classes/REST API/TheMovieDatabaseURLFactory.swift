//
//  URLFactory.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

/// Builds URLs for _themoviedb.org_ REST Endpoints
internal struct TheMovieDatabaseURLFactory {
	
	/// Base URL for _themoviedb.org_ REST API
    private let api = "https://api.themoviedb.org/3"
    
	/// Base URL for _themoviedb.org_ movie poster images
    private let imagesAPI = "https://image.tmdb.org/t/p"
	
	/// The API key for accessing _themoviedb.org_ RESTAPI
    private let apiKey = "2a61185ef6a27f400fd92820ad9e8537"
	
	/// Builds a URL for searching for movies with a query
	/// - Parameter searchQuery: The search query
    func makeSearchMoviesURL(forQuery searchQuery: String) -> URL? {
        
        guard var url = URL(string: api) else { return nil }
        
        url = url.appendingPathComponent(TheMovieDatabaseEndpoint.searchMovie)

        let urlParameters = ["api_key": apiKey,
                             "query": searchQuery]
        
        url = url.appendingQueryParameters(urlParameters)
        
        return url
    }
	
	/// Builds a URL for downloading movie posters at a given path
	/// - Parameters:
	///   - path: The movie poster path
	///   - size: The size of the poster image being requested
	///   - quality: The quality of the poster image being requested
    func makeImageDownloadURL(atPath path: String,
                              size: CGSize,
                              quality: ImageQuality) -> URL? {
        
        guard var url = URL(string: imagesAPI) else { return nil }
        
        url = url.appendingPathComponent("w600_and_h900_bestv2")
        url = url.appendingPathComponent(path)
        
        return url
    }
}
