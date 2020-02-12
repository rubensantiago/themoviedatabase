//
//  URLSession.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

internal extension URLSession {
	
	/// A generic method that decodes the response of a `URLSessionTask`
	/// - Parameters:
	///   - url: The URL for the REST service to be requested
	///   - completionHandler: A completion handler to decode the response
	fileprivate func codableTask<T: Codable>(with url: URL,
                                             completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
			do {
				completionHandler(try self.newJSONDecoder().decode(T.self, from: data), response, nil)
			} catch {
				print(error)
			}
            
        }
    }
	
	/// A convenience method that builds a `URLSessionTask` to search for movies on _themoviedb.org_
	/// - Parameters:
	///   - url: The URL for the REST service to be requested
	///   - completionHandler: A completion handler to decode the response
    func searchMoviesResponseTask(with url: URL,
                                  completionHandler: @escaping (SearchMoviesResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
	
	/// A convenience method that builds a `URLSessionTask` to download movie posters from _themoviedb.org_
	/// - Parameters:
	///   - url: The URL for the REST service to be requested
	///   - completionHandler: A completion handler to handle the movie poster image
	func getMoviePosterTask(with url: URL,
								  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.dataTask(with: url, completionHandler: completionHandler)
	}
}

// MARK: - Helper Functions for Creating JSON Decoder
extension URLSession {
	
	/// A convenience method to create a configured `JSONDecoder` for use with Decodable entities
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
}
