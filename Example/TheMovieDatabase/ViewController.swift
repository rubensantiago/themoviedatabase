//
//  ViewController.swift
//  TheMovieDatabase_Example
//
//  Created by Rubén on 2/11/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	fileprivate var searchController: UISearchController!
	
	fileprivate var resultsTableController: MovieSearchResultsTableViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSearchResultsController()
	}
	
	fileprivate func setupSearchResultsController() {
		resultsTableController =
			self.storyboard?.instantiateViewController(withIdentifier: "MovieSearchResultsTableViewController") as? MovieSearchResultsTableViewController
		
		searchController = UISearchController(searchResultsController: resultsTableController)
		
		searchController.delegate = resultsTableController
		searchController.searchBar.delegate = resultsTableController
		navigationItem.searchController = searchController
		resultsTableController.searchController = searchController
		
		searchController.searchBar.scopeButtonTitles = ["All", "The Movie DB", "IMDb"]
		searchController.searchBar.selectedScopeButtonIndex = 1
	}
}
