//
//  PosterCard.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import SwiftUI

struct PosterCard: View {
    let movie: Movie
    
    var body: some View {
        moviePosterCard(movie: movie)
    }
}

struct PosterCard_Previews: PreviewProvider {
    static var previews: some View {
        PosterCard(movie: Movie.localMovie)
    }
}

extension PosterCard {
    func moviePosterCard(movie: Movie) -> some View {
        VStack {
            ZStack {
                RectangleView()
                moviePoster(movie: movie)
            }
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
            movieInfo(movie: movie)
        }
        .frame(width: 90, height: 150)
    }
    
    func moviePoster(movie: Movie) -> some View {
        AsyncImage(url: movie.posterURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Image(systemName: "video")
            } else {
                ProgressView()
            }
        }
    }
    
    func movieInfo(movie: Movie) -> some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .lineLimit(1)
                .font(.caption)
            
            Text("☆ \(movie.voteAverage, specifier: "%.1f")")
                .foregroundColor(.gray)
                .fontWeight(.bold)
                .font(.caption2)
        }
    }
}
