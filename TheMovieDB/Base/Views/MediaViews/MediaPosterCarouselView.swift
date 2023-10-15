//
//  MediaPosterCarouselView.swift
//  TheMovieDB
//
//  Created by Eric on 15/10/2023.
//

import SwiftUI

struct MediaPosterCarouselView: View {
    let title: String
    let content: [Media]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Spacer()
                
                NavigationLink(value: content) {
                    Text("Show all")
                        .font(.callout)
                        .fontWeight(.regular)
                }
                .tint(.orange)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 12) {
                    ForEach(content) { movie in
                        NavigationLink(value: movie) {
                            MediaPosterCard(content: movie)
                                .frame(width: 94, height: 176)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MediaPosterCarouselView(title: "Movie of the day", content: Media.localMovies)
    }
}

#Preview {
    NavigationStack {
        MediaPosterCarouselView(title: "Movie of the day", content: Media.localTVs)
    }
}
