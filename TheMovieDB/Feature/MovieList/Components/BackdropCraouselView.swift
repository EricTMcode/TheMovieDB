//
//  BackdropCraouselView.swift
//  TheMovieDB
//
//  Created by Eric on 30/06/2023.
//

import SwiftUI

struct BackdropCraouselView: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 20) {
                ForEach(movies) { movie in
                    BackdropCard(movie: movie)
                        .frame(width: 332)
                }
            }
        }
        .padding(.leading)
    }
}

struct BackdropCraousel_Previews: PreviewProvider {
    static var previews: some View {
        BackdropCraouselView(movies: Movie.localMovies)
    }
}
