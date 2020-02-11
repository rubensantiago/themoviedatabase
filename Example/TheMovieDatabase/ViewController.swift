//
//  ViewController.swift
//  TheMovieDatabase
//
//  Created by Ruben Santiago on 02/11/2020.
//  Copyright (c) 2020 Ruben Santiago. All rights reserved.
//

import UIKit
import TheMovieDatabase

class ViewController: UIViewController {

    let movieDB = TheMovieDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDB.searchFor(movieNamed: "harry potter")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

