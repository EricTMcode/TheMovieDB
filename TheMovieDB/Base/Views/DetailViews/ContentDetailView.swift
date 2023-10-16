//
//  ContentDetailView.swift
//  TheMovieDB
//
//  Created by Eric on 16/10/2023.
//

import SwiftUI

struct ContentDetailView: View {
    let content: Media
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: false) {
                GeometryReader { geo in
                    ZStack(alignment: .bottomLeading) {
                        ContentBackdropView
                            .frame(width: geo.size.width, height: GeometryHelper.getHeightForHeaderImage(geo))
                        
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.5))
                            .frame(width: geo.size.width, height: 80)
                        
                        ContentDetailTitleView
                    }
                    
                }
                .frame(height: UIScreen.main.bounds.height * 0.5)
                
                VStack(alignment: .leading, spacing: 20) {
                    ContentOverviewDetailView
                    ContentCastDetailView
                }
                .padding(.horizontal)
                .padding(.bottom, 90)
            }
        }
        .ignoresSafeArea()
    }
    
    private var ContentBackdropView: some View {
        AsyncImage(url: content.backdropOriginalURL) { phase in
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
    
    private var ContentDetailTitleView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(content.contentTitle)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .lineLimit(1)
            
            Text(content.infoText)
                .font(.callout)
                .fontWeight(.medium)
            
            Text(content.genreText)
                .font(.footnote)
        }
        .foregroundStyle(.white.opacity(0.7))
        .shadow(radius: 7)
        .padding(.leading)
        .padding(.bottom,8)
    }
    
    private var ContentOverviewDetailView: some View {
        VStack(alignment: .leading, spacing: 12) {
            MediaDetailTitle(text: "Overview")
            Text(content.overview)
                .font(.callout)
        }
        .padding(.top, 5)
    }
    
    private var ContentCastDetailView: some View {
        VStack(alignment: .leading, spacing: 15) {
            MediaDetailTitle(text: "Distribution")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 10) {
                    if let cast = content.cast, !cast.isEmpty {
                        ForEach(cast.prefix(9)) { cast in
                            NavigationLink(value: cast) {
                                VStack(alignment: .leading) {
                                    ZStack {
                                        RectangleView()
                                            .shadow(radius: 4)
                                        
                                        AsyncImage(url: cast.profileURL) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .shadow(radius: 4)
                                            } else if phase.error != nil {
                                                Image(systemName: "person")
                                                    .font(.system(size: 25))
                                                    .opacity(0.5)
                                            } else {
                                                ProgressView()
                                            }
                                        }
                                    }
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(20)
                                    
                                    Text(cast.name)
                                    Text(cast.character)
                                        .foregroundStyle(.secondary)
                                }
                                .font(.footnote)
                                .frame(width: 80)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentDetailView(content: Media.localMovie)
}
