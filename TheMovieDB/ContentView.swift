//
//  ContentView.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            TVListView()
                .tabItem {
                    Label("TV Show", systemImage: "sparkles.tv")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .onAppear {
            // correct the transparency bug for Tab bars
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
