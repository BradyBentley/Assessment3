//
//  MovieTableViewCell.swift
//  Assessment3
//
//  Created by Brady Bentley on 12/14/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    var movie: Movie? {
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        guard let movie = movie else { return }
        ratingLabel.text = "\(movie.rating)"
        overviewLabel.text = movie.overview
        titleLabel.text = movie.title
        MovieController.fetchMovieImage(for: movie) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
}
