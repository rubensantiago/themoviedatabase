//
//  URL.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

extension URL {

	/// Appends given query parameters onto the URL
	/// - Parameter parametersDictionary: A Dictionary of query parameters to add to a URL
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
