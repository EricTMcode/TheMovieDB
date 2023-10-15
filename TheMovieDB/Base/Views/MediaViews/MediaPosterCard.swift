//
//  MediaPosterCard.swift
//  TheMovieDB
//
//  Created by Eric on 15/10/2023.
//

import SwiftUI

enum PosterCardOrientationType {
    case vertical
    case horizontal
}

struct MediaPosterCard: View {
    let content: Media
    var orientationType: PosterCardOrientationType = .vertical
    
    var body: some View {
        containerView
    }
    
    @ViewBuilder
    private var containerView: some View {
        if case .vertical = orientationType {
            VStack(alignment: .leading) {
                imageView
                textView
            }
        } else {
            HStack(alignment: .top, spacing: 16) {
                imageView
                    .frame(width: 60 ,height: 120)
                textView
            }
        }
    }
    
    private var imageView: some View {
        ZStack {
            RectangleView()
            
            MovieRemoteImage(urlString: content.posterString)
                .scaledToFill()
        }
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
    }
    
    @ViewBuilder
    private var textView: some View {
        if case .vertical = orientationType {
            VStack(alignment: .leading) {
                Text(content.contentTitle)
                    .font(.caption)
                
                Text("☆ \(content.voteAverageText)")
                    .foregroundColor(.secondary)
                    .font(.caption.bold())
            }
            .lineLimit(1)
        } else {
            VStack(alignment: .leading) {
                Text(content.contentTitle)
                    .font(.headline)
                
                Text("☆ \(content.voteAverageText) - \(content.yearText)")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            .lineLimit(1)
        }
    }
}

#Preview {
    MediaPosterCard(content: Media.localMovie)
        .frame(width: 204, height: 306)
        .padding()
}

#Preview {
    MediaPosterCard(content: Media.localMovie, orientationType: .horizontal)
        .frame(width: 204, height: 306)
}

#Preview {
    MediaPosterCard(content: Media.localTV)
        .frame(width: 204, height: 306)
        .padding()
}

#Preview {
    MediaPosterCard(content: Media.localTV, orientationType: .horizontal)
        .frame(width: 204, height: 306)
}

