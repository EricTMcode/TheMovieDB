//
//  BackdropCraouselView.swift
//  TheMovieDB
//
//  Created by Eric on 30/06/2023.
//

import SwiftUI

struct BackdropCarouselView: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 20) {
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        BackdropCard(movie: movie)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.leading)
        }
    }
}

struct BackdropCraousel_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BackdropCarouselView(movies: Movie.localMovies)
        }
    }
}
