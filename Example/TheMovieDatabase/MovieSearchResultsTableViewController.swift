//
//  MovieSearchResultsTableViewController.swift
//  TheMovieDatabase_Example
//
//  Created by Ruben on 2/11/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import UIKit
import TheMovieDatabase

class MovieSearchResultsTableViewController: UITableViewController {
	
	var movies = [MovieSearchResultItem]() {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
		
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		let emptyStateNib = UINib(nibName: CellNib.emptyState, bundle: nil)
		tableView.register(emptyStateNib, forCellReuseIdentifier: CellReuseIdentifier.emptyState)

		let movieSummaryNib = UINib(nibName: CellNib.movieSummary, bundle: nil)
		tableView.register(movieSummaryNib, forCellReuseIdentifier: CellReuseIdentifier.movieSummary)
	}
	
	// MARK: - UITableViewDataSource
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movies.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.movieSummary, for: indexPath) as! MovieSummaryTableViewCell
		
		let movie = movies[indexPath.row]
		
		cell.movieTitle.text = movie.originalTitle
		cell.movieDescription.text = movie.overview

		return cell
	}
}
