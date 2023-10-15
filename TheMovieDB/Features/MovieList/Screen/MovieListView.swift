//
//  MovieListView.swift
//  TheMovieDB
//
//  Created by Eric on 15/10/2023.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var vm = MovieListViewModel()
    
    
    var body: some View {
        VStack {
            ForEach(vm.topRated) { movie in
                Text(movie.movieTitle)
            }
        }
        .task {
            await vm.populateMovies()
        }
    }
}

#Preview {
    MovieListView()
}
