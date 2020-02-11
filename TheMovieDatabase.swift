//
//  TheMovieDatabase.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

public class TheMovieDatabase {
    
    private let urls = URLFactory()
    
    public init() { }
    
    public func searchFor(movieNamed searchQuery: String) {
        
        guard let url = urls.makeSearchMoviesURL(forQuery: searchQuery) else { return }
        
        let task = URLSession.shared.searchMoviesResponseTask(with: url) {
            searchMoviesResponse, response, error in
            
            if searchMoviesResponse != nil {
                print(searchMoviesResponse)
                // pass to completion handler here
            }
        }
        
        task.resume()
    }
}

// MARK - Images
public extension TheMovieDatabase {
    func downloadImage(atPath path: String,
                       size: CGSize,
                       quality: ImageQuality,
                       completion: ()->()) {
        
        guard let url = urls.makeImageDownloadURL(atPath: path,
                                                  size: size,
                                                  quality: quality) else { return }
        
    }
}
