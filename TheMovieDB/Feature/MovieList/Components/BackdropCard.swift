//
//  BackdropCard.swift
//  TheMovieDB
//
//  Created by Eric on 30/06/2023.
//

import SwiftUI

struct BackdropCard: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RectangleView()
                
                AsyncImage(url: movie.backdropURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Image(systemName: "video")
                    } else {
                        ProgressView()
                    }
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(movie.title)
                    .font(.subheadline)
                    .lineLimit(1)
                Text("2023")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct BackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        BackdropCard(movie: Movie.localMovie)
            .padding()
    }
}
