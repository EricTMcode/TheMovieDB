//
//  MovieTrending.swift
//  TheMovieDB
//
//  Created by Eric on 03/07/2023.
//

import Foundation

struct MovieTrending: Codable {
    let results: [Movie]
    let page: Int
}
