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
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 15) {
                    ForEach(movies) { movie in
                        PosterCard(movie: movie)
                    }
                }
                .padding()
            }
        }
    }
}

struct PosterCaroussel_Previews: PreviewProvider {
    static var previews: some View {
        PosterCarousselView(title: "Movie of the day", movies: Movie.localMovies)
    }
}
