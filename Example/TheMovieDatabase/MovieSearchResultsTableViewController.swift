//
//  MovieSearchResultsTableViewController.swift
//  TheMovieDatabase_Example
//
//  Created by Ruben on 2/11/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import UIKit
import TheMovieDatabase

class MovieSearchResultsTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
	
	fileprivate let db: AbstractMovieDatabase = TheMovieDatabaseAdapter()
	
	fileprivate var movieDB: TheMovieDatabaseAdapter
	
	weak var searchController: UISearchController?
	
	var movies: [AnyHashable: MovieSearchResultItem] = [:] {
		didSet {
			movieKeys = Array(movies.keys)
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
	
	var movieKeys: [AnyHashable] = []
	
	required init?(coder: NSCoder) {
		movieDB = db as! TheMovieDatabaseAdapter
		super.init(coder: coder)
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView,
							numberOfRowsInSection section: Int) -> Int {
		return movies.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "movieSummaryCell") as! MovieSummaryTableViewCell
		
		let key = movieKeys[indexPath.row]
		guard let movie = movies[key] else { return cell }
		
		cell.movieTitle.text = movie.originalTitle
		
		setDescription(forMovie: movie, inCell: cell)
		
		guard let posterPath = movie.posterPath else { return cell }
		setPoster(atPath: posterPath, inCell: cell)
		
		return cell
	}
		
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.count > 2 {
			movieDB.searchFor(movieNamed: searchText) { (searchResults) in
				self.movies = searchResults
			}
		}
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		movieDB.searchFor(movieNamed: searchBar.text ?? "") { (searchResults) in
			self.movies = searchResults
			DispatchQueue.main.async {
				self.searchController?.dismiss(animated: true, completion: nil)
			}
		}
	}
}

// MARK: Helpers
fileprivate extension MovieSearchResultsTableViewController {
	
	func setPoster(atPath posterPath: String, inCell cell: MovieSummaryTableViewCell) {
		
		movieDB.getImage(atPath: posterPath) { (downloadedImage) in
			DispatchQueue.main.async {
				cell.posterImage.image = downloadedImage
			}
		}
	}
	
	func setDescription(forMovie movie: MovieSearchResultItem, inCell cell: MovieSummaryTableViewCell) {
		if movie.overview.count > 0 {
			cell.movieDescription.text = movie.overview
		} else {
			cell.movieDescription.text = "No Description Available"
		}
	}
}
