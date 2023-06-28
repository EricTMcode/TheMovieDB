//
//  Movie.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
}
