//
//  Movie.swift
//  Assessment3
//
//  Created by Brady Bentley on 12/14/18.
//  Copyright © 2018 Brady. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let title: String
    let rating: Double
    let image: String
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case image = "poster_path"
        case overview
    }
}

