//
//  MovieSummaryTableViewCell.swift
//  TheMovieDatabase_Example
//
//  Created by Ruben on 2/11/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class MovieSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.maskWithRoundedCorners(radius: 20.0)
    }
}

extension UIView {
    func maskWithRoundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
