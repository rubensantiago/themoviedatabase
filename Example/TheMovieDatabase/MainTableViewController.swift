//
//  MainTableViewController.swift
//  Movies
//
//  Created by Rubén on 2/12/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import UIKit
import TheMovieDatabase

class MainTableViewController: UITableViewController, UISearchControllerDelegate {
	
	fileprivate let db: AbstractMovieDatabase = TheMovieDatabaseAdapter()
	
	fileprivate var movieDB: TheMovieDatabaseAdapter

	fileprivate var searchController: UISearchController!
	
	fileprivate var resultsTableController: MovieSearchResultsTableViewController!
	
	var movies = [MovieSearchResultItem]() {
		didSet {
			self.resultsTableController.movies = self.movies
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}

	required init?(coder: NSCoder) {
		
		movieDB = db as! TheMovieDatabaseAdapter
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
        
		super.viewDidLoad()
		registerCells()
		setupSearchResultsController()
    }
}

// MARK: - Table view data source
extension MainTableViewController {
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		guard movies.count > 0 else { return 1 }
		return movies.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "movieSummaryCell") as! MovieSummaryTableViewCell
		
		guard movieExistsForIndexPath(indexPath)
			else {
				return tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.emptyState, for: indexPath)
		}
		
		let movie = movies[indexPath.row]
		
		cell.movieTitle.text = movie.originalTitle
		setDescription(forMovie: movie, inCell: cell)
		
		guard let posterPath = movie.posterPath else { return cell }
		setPoster(atPath: posterPath, inCell: cell)
		
		return cell
	}
	
	fileprivate func movieExistsForIndexPath(_ indexPath: IndexPath) -> Bool {
		movies.count > 0 && (movies.endIndex - 1) >= indexPath.row
	}
}

extension MainTableViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		if searchText.count > 2 {
			DispatchQueue.global().async {
				self.movieDB.searchFor(movieNamed: searchText) { (searchResults) in
					self.movies = searchResults
					self.resultsTableController.movies = searchResults
				}
			}
			
		} else if searchText.count == 0 {
			clearSearchResults()
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

// MARK: - Helpers
fileprivate extension MainTableViewController {
	
	func setupSearchResultsController() {
		
		resultsTableController =
			self.storyboard?.instantiateViewController(withIdentifier: "MovieSearchResultsTableViewController") as? MovieSearchResultsTableViewController
		
		resultsTableController.tableView.delegate = self
		resultsTableController.tableView.dataSource = self
		resultsTableController.movies = movies
		searchController = UISearchController(searchResultsController: resultsTableController)
		searchController.delegate = self
		searchController.searchBar.delegate = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.scopeButtonTitles = ["All", "The Movie DB", "IMDb"]
		searchController.searchBar.selectedScopeButtonIndex = 1
		
		navigationItem.searchController = searchController
		
		definesPresentationContext = true
	}
	
	func registerCells() {
		
		let emptyStateNib = UINib(nibName: CellNib.emptyState, bundle: nil)
		tableView.register(emptyStateNib, forCellReuseIdentifier: CellReuseIdentifier.emptyState)
		
		let movieSummaryNib = UINib(nibName: CellNib.movieSummary, bundle: nil)
		tableView.register(movieSummaryNib, forCellReuseIdentifier: CellReuseIdentifier.movieSummary)
	}
	
	func setPoster(atPath posterPath: String, inCell cell: MovieSummaryTableViewCell) {
		
		DispatchQueue.global().async {
			self.movieDB.getImage(atPath: posterPath) { (downloadedImage) in
				DispatchQueue.main.async {
					cell.posterImage.image = downloadedImage
				}
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
	
	func clearSearchResults() {
		
		self.movies.removeAll()
		self.resultsTableController.movies.removeAll()
	}
}
