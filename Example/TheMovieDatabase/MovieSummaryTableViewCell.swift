//
//  MovieSummaryTableViewCell.swift
//  TheMovieDatabase_Example
//
//  Created by Ruben on 2/11/20.
//  Copyright © 2020 Ruben Santiago. All rights reserved.
//

import UIKit

class MovieSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
	
	override func awakeFromNib() {
		movieTitle.text = ""
		movieDescription.text = ""
	}
    
    override func layoutSubviews() {
        super.layoutSubviews()
		posterImage.maskWithRoundedCorners(radius: 6.0)
    }
	
	override func prepareForReuse() {
		movieTitle.text = ""
		movieDescription.text = ""
		posterImage.image = nil
	}
}
