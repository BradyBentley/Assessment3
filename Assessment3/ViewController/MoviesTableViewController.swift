//
//  MoviesTableViewController.swift
//  Assessment3
//
//  Created by Brady Bentley on 12/14/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    // MARK: - Properties
    var movies: [Movie] = []
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension MoviesTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = movieSearchBar.text, !searchTerm.isEmpty else { return }
        MovieController.fetchMovie(with: searchTerm) { (movies) in
            guard let movies = movies else { return }
            self.movies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.movieSearchBar.text = ""
            }
        }
    }
}
