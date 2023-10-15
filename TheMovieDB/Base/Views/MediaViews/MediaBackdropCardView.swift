//
//  MediaBackdropCardView.swift
//  TheMovieDB
//
//  Created by Eric on 15/10/2023.
//

import SwiftUI

struct MediaBackdropCardView: View {
    let content: Media
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                RectangleView()
                
                AsyncImage(url: content.backdropURL) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Image(systemName: "video")
                    } else {
                        ProgressView()
                    }
                }
            }
            .overlay {
                Image(systemName: "play.circle")
                    .font(.system(size: 80))
                    .fontWeight(.light)
                    .foregroundColor(.white.opacity(0.8))
                    .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(content.contentTitle)
                    .font(.subheadline)
                    .lineLimit(1)
                
                Text("2023")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    MediaBackdropCardView(content: Media.localMovie)
        .padding()
}

#Preview {
    MediaBackdropCardView(content: Media.localTV)
        .padding()
}
