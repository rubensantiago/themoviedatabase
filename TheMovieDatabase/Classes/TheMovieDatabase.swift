//
//  TheMovieDatabase.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation
import UIKit

/// The main interface for fetching data from _themoviedb.org_
public class TheMovieDatabase {
	
	/// URL factory for _themoviedb.org_ REST services
	private let urls = TheMovieDatabaseURLFactory()
	
	/// A cache for movie poster images
	private let cache: NSCache<NSString, AnyObject>?
	
	/// Designated initializer
	public init(with cache: NSCache<NSString, AnyObject>? = nil) {
		if let cache = cache {
			self.cache = cache
		} else {
			self.cache = NSCache<NSString, AnyObject>()
		}
	}
	
	/// Searches for movies on _themoviedb.org_ using a given search query
	/// - Parameters:
	///   - searchQuery: A search query
	///   - completion: A completion handler to handle the HTTP response
	public func searchFor(movieNamed searchQuery: String,
						  completion: @escaping MovieSearchResultsCompletionHandler) {
		
		DispatchQueue.global().async {
			guard let url = self.urls.makeSearchMoviesURL(forQuery: searchQuery) else { return }
			
			let task = URLSession.shared.searchMoviesResponseTask(with: url) {
				searchMoviesResponse, response, error in
				
				if let searchMoviesResponseHasResults = searchMoviesResponse {
					completion(searchMoviesResponseHasResults.results ?? [MovieSearchResultItem]())
				}
			}
			
			task.resume()
		}
	}
}

// MARK - Images
public extension TheMovieDatabase {
	
	/// Retrieves a movie poster from the cache. If it does not exist in the cache, it will download it from the _themoviedb.org_
	/// - Parameters:
	///   - path: the filepath where the image can be found
	///   - size: The requested size of the poster to be returned
	///   - quality: The image quality of the poster that is returned
	///   - completion: A closure to handle the movie poster
	func getImage(atPath path: String,
				  size: CGSize = CGSize(width: 600, height: 900),
				  quality: ImageQuality = .best,
				  completion: @escaping ImageDownloadCompletionHandler) {
		
		DispatchQueue.global().async {
			guard let imageURL = self.urls.makeImageDownloadURL(atPath: path,
														   size: size,
														   quality: quality)
				else {
					completion(nil)
					return
			}
			
			guard let cachedMoviePosterImage = self.cache?.object(forKey: path as NSString)
				else {
					
					let task = URLSession.shared.getMoviePosterTask(with: imageURL) { (data, response, error) in
						
						if let data = data,
							let downloadedMoviePosterImage = UIImage(data: data) {
							
							self.cache?.setObject(downloadedMoviePosterImage, forKey: path as NSString)
							completion(downloadedMoviePosterImage)
						}
					}
					
					task.resume()
					return
			}
			
			guard let cachedMoviePoster = cachedMoviePosterImage as? UIImage
				else {
					completion(nil)
					return
			}
			
			completion(cachedMoviePoster)
		}
	}
}
