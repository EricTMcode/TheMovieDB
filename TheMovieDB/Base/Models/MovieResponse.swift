//
//  MovieResponse.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}
