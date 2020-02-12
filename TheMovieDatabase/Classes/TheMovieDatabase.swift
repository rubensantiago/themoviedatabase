//
//  TheMovieDatabase.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation
import UIKit

public typealias MovieSearchResultsCompletionHandler = ([MovieSearchResultItem]) -> Void

public typealias ImageDownloadCompletionHandler = (UIImage?) -> Void

public class TheMovieDatabase {
	
	
	private let urls = URLFactory()
	
	private let cache = NSCache<NSString, AnyObject>()
	
	public init() { }
	
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
			
			guard let cachedMoviePosterImage = self.cache.object(forKey: path as NSString)
				else {
					
					let task = URLSession.shared.getMoviePosterTask(with: imageURL) { (data, response, error) in
						
						if let data = data,
							let downloadedMoviePosterImage = UIImage(data: data) {
							
							self.cache.setObject(downloadedMoviePosterImage, forKey: path as NSString)
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
