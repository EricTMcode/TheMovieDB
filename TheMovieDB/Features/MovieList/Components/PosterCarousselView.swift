//
//  PosterCarousselView.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import SwiftUI

struct PosterCarousselView: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            titleView(title: title, movies: movies)
            movieView(movies: movies)
        }
    }
}

struct PosterCaroussel_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PosterCarousselView(title: "Movie of the day", movies: Movie.localMovies)
        }
    }
}

extension PosterCarousselView {
    func titleView(title: String, movies: [Movie]) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
            
            Spacer()
            
            NavigationLink(value: movies) {
                Text("Show all")
                    .font(.callout)
                    .fontWeight(.regular)
            }
            .tint(.orange)
        }
        .padding(.horizontal)
    }
    
    func movieView(movies: [Movie]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 15) {
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        PosterCard(movie: movie)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
}
