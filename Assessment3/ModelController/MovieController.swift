//
//  MovieController.swift
//  Assessment3
//
//  Created by Brady Bentley on 12/14/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import UIKit

class MovieController {
    // MARK: - properties
    static let baseUrl = URL(string: "https://api.themoviedb.org/3")
    
    // MARK: - Fetch
    static func fetchMovie(with movieName: String, completion: @escaping ([Movie]?) -> Void) {
        //URL
        guard var url = baseUrl else { completion([]) ; return }
        url.appendPathComponent("search")
        url.appendPathComponent("movie")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let keyQueryItem = URLQueryItem(name: "api_key", value: "ca4c06450ff6463cdeac6e6286782861")
        let nameQueryItem = URLQueryItem(name: "query", value: movieName)
        components?.queryItems = [keyQueryItem, nameQueryItem]
        guard let requestUrl = components?.url else { completion([]) ; return }
        //Request
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        print(request.url?.absoluteURL ?? "No URL")
        //DataTask+resume
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("❌ Error with dataTask: \(error.localizedDescription)")
            }
            guard let data = data else { completion([]) ; return }
            let jsonDecoder = JSONDecoder()
            do {
                let topLevelDictionary = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                let movie = topLevelDictionary.results
                completion(movie)
            } catch {
                print("❌Error decoding data \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    static func fetchMovieImage(for movie: Movie, completion: @escaping ((UIImage?) -> Void)) {
        // URL
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(movie.image)") else { completion(nil) ; return }
        //Request
        var request = URLRequest(url: imageUrl)
        request.httpMethod = "GET"
        request.httpBody = nil
        //DataTask+Resume
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("❌Error with DataTask: \(error.localizedDescription)")
            }
            guard let data = data else { completion(nil) ; return }
            let image = UIImage(data: data)
            completion(image)
            }.resume()
    }
}

