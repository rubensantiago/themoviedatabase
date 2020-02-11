//
//  URLFactory.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

internal struct URLFactory {

    private let api = "https://api.themoviedb.org/3"
    
    private let imagesAPI = "https://image.tmdb.org/t/p"
    
    private let apiKey = "2a61185ef6a27f400fd92820ad9e8537"
    
    func makeSearchMoviesURL(forQuery searchQuery: String) -> URL? {
        
        guard var url = URL(string: api) else { return nil }
        
        url = url.appendingPathComponent(Endpoint.searchMovie)

        let urlParameters = ["api_key": apiKey,
                             "query": searchQuery]
        
        url = url.appendingQueryParameters(urlParameters)
        
        return url
    }
    
    func makeImageDownloadURL(atPath path: String,
                              size: CGSize,
                              quality: ImageQuality) -> URL? {
        
        guard var url = URL(string: imagesAPI) else { return nil }
        
        url = url.appendingPathComponent("w600_and_h900_bestv2")
        url = url.appendingPathComponent(path)
        
        return url
    }
}
