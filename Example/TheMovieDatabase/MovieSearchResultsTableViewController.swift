//
//  MovieSearchResultsTableViewController.swift
//  TheMovieDatabase_Example
//
//  Created by Ruben on 2/11/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import TheMovieDatabase

class MovieSearchResultsTableViewController: UITableViewController {

    let movieDB = TheMovieDatabase()
    var movies: [AnyHashable: Movie] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDB.searchFor(movieNamed: "harry potter")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
