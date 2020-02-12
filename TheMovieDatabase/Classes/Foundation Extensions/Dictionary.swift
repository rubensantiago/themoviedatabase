//
//  Dictionary.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

extension Dictionary {
	
	/// A convenience computed property that allows the easy conversion of a Dictionary into a valid HTTP URI
	/// query parameters string
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}
