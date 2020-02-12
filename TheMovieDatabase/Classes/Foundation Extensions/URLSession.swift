//
//  URLSession.swift
//  TheMovieDatabase
//
//  Created by Ruben on 2/11/20.
//

import Foundation

extension URLSession {
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

    func searchMoviesResponseTask(with url: URL,
                                  completionHandler: @escaping (SearchMoviesResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
	
	func getMoviePosterTask(with url: URL,
								  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.dataTask(with: url, completionHandler: completionHandler)
	}
}

// MARK: - Helper functions for creating encoders and decoders
extension URLSession {

    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
}
