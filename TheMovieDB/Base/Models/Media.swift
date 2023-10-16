//
//  Media.swift
//  TheMovieDB
//
//  Created by Eric on 15/10/2023.
//

import Foundation

struct MediaResponse: Codable {
    let results: [Media]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}

struct Media: Codable, Hashable, Identifiable {
    let id: Int
    let title: String?
    let name: String?
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let genres: [Genres]?
    let credits: Credit?
    let recommendations: MediaRecommendationsResponse?
    let videos: MediaVideoResponse?
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var contentTitle: String {
        title ?? name!
    }
    
    var movieTitle: String {
        title ?? "n/a"
    }
    
    var TVTitle: String {
        name ?? "n/a"
    }
    
    var posterURL: URL {
        return URL(string: "\(Constants.imgUrl)\(posterPath ?? "")")!
    }
    
    var posterString: String {
        return "\(Constants.imgUrl)\(posterPath ?? "")"
    }
    
    var backdropURL: URL {
        return URL(string: "\(Constants.imgUrl)\(backdropPath ?? "")")!
    }
    
    var backdropOriginalURL: URL {
        return URL(string: "\(Constants.imgOriginalUrl)\(backdropPath ?? "")")!
    }
    
    var voteAverageText: String {
        return String(format: "%.1f", voteAverage)
    }
    
    var genreText: String {
        guard let genres = genres else {
            return "n/a"
        }
        return genres.prefix(3).map { $0.name }.joined(separator: ", ")
    }
    
    var durationText: String {
        guard let runtime = runtime, runtime > 0 else {
            return "n/a"
        }
        return Media.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    var yearText: String {
        guard let releaseDate = releaseDate, let date = Media.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Media.yearFormatter.string(from: date)
    }
    
    var infoText: String {
        return "★ \(voteAverageText)   \(durationText)   \(yearText)"
    }
    
    var cast: [Cast]? {
        credits?.cast
    }
    
    var recommendationsVideo: [Media]? {
        return (recommendations?.results.isEmpty)! ? nil : recommendations?.results
    }
    
    var video: [MovieVideo]? {
        videos?.results.filter { $0.type.lowercased() == "trailer" }
    }
   
    var shareDescription: String {
        """
        Movie Recommendation
        
        \(contentTitle)
        ★ \(voteAverageText) - \(durationText) - \(yearText)
        """
    }
}

struct MediaRecommendationsResponse: Codable, Hashable {
    let results: [Media]
}

struct MediaVideoResponse: Codable, Hashable {
    let results: [MovieVideo]
}

struct MovieVideo: Codable, Identifiable, Hashable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
}

struct Credit: Codable, Hashable {
    let cast: [Cast]
}

struct Cast: Codable, Hashable, Identifiable {
    let id: Int
    let character: String
    let name: String
    let profilePath: String?
    
    var profileURL: URL {
        return URL(string: "\(Constants.imgUrl)\(profilePath ?? "")")!
    }
}

struct Genres: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
}
