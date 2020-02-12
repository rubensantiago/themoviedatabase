//
//  CompletionHandlers.swift
//  TheMovieDatabase
//
//  Created by Rubén on 2/12/20.
//

import Foundation

/// Completion handler that returns Movie Search Result Items
public typealias MovieSearchResultsCompletionHandler = ([MovieSearchResultItem]) -> Void

/// Completion handler that returns a UIImage 
public typealias ImageDownloadCompletionHandler = (UIImage?) -> Void
