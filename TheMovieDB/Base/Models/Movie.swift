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
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    
    var posterURL: URL {
        return URL(string: "\(Constant.imgUrl)\(posterPath ?? "")")!
    }
    
    var backdropURL: URL {
        return URL(string: "\(Constant.imgUrl)\(backdropPath ?? "")")!
    }
}
