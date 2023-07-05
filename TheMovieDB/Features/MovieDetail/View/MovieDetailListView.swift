//
//  MovieDetailListView.swift
//  TheMovieDB
//
//  Created by Eric on 04/07/2023.
//

import SwiftUI

struct MovieDetailListView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                GeometryReader { geo in
                    ZStack(alignment: .bottomLeading) {
                        MovieDetailImageView
                            .frame(width: geo.size.width, height: GeometryHelper.getHeightForHeaderImage(geo))
                        
                        Rectangle()
                            .foregroundColor(.black.opacity(0.5))
                            .frame(width: geo.size.width, height: 80)
                        
                        MovieDetailTitleView
                    }
                    .offset(x: 0, y: GeometryHelper.getOffsetForHeaderImage(geo))
                }
                .frame(height: UIScreen.main.bounds.height * 0.5)
                VStack(alignment: .leading, spacing: 20) {
                    MovieDetailOverviewView
                }
                .padding([.leading, .trailing])
            }
        }
        .ignoresSafeArea()
    }
    
    private var MovieDetailImageView: some View {
        AsyncImage(url: movie.backdropOriginalURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Image(systemName: "film")
                    .font(.system(size: 48))
                    .opacity(0.5)
            } else {
                ProgressView()
            }
        }
    }
    
    private var MovieDetailTitleView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(movie.title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(1)
            
                Text("☆ \(movie.voteAverage, specifier: "%.1f")   \("1h25")   \("2023")")
                    .font(.callout)
                    .fontWeight(.medium)
            
            Text(movie.genreText)
                .font(.footnote)
        }
        .foregroundColor(.white.opacity(0.7))
        .shadow(radius: 7)
        .padding(.leading)
        .padding(.bottom, 8)
    }
    
    private var MovieDetailOverviewView: some View {
        VStack(alignment: .leading, spacing: 12) {
            MovieDetailTitle(text: "Overview")
            Text(movie.overview)
                .font(.callout)
        }
        .padding(.top, 5)
    }
}

struct MovieDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailListView(movie: Movie.localMovie)
    }
}
