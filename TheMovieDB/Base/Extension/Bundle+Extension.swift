//
//  Bundle+Extension.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import Foundation

// MARK: - BUNDLE EXTENSION

extension Bundle {
    
    func decode<T: Codable>(filename: String) -> T {
        // 1. Locate the JSON file
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to locate \(filename) in bundle.")
        }
        
        // 2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename) from bundle.")
        }
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // 4. Create a property for the decoded data
        guard let decodedModel = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(filename) from bundle.")
        }
        
        // 5. Return the ready-to-use data
        return decodedModel
    }
}

// MARK: - MOVIE EXTENSION

extension Media {
    
    // 1. Decode movie_list.json for development
    static var localMovies: [Media] {
        let response: MediaResponse = Bundle.main.decode(filename: "movie_list")
        return response.results
    }
    
    // 2. Create an example movie for development
    static var localMovie: Media {
        localMovies[0]
    }
    
    static var localTV: Media {
        let tv: Media = Bundle.main.decode(filename: "tv_info")
        return tv
    }
    
//    // 3. Decode movie_credits.json for development
//    static var localCredits: [MovieCast] {
//        let response: MovieCredit = Bundle.main.decode(filename: "movie_credits")
//        return response.cast
//
//    }
//
//    // 4. Decode movie_similar.json for development
//    static var localSimilar: [Movie] {
//        let response: MovieSimilarResponse = Bundle.main.decode(filename: "movie_similar")
//        return response.results
//    }
}
