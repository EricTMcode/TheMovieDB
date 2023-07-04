//
//  MovieListView.swift
//  TheMovieDB
//
//  Created by Eric on 28/06/2023.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var vm = MovieListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if vm.errorMessage != nil {
                    FavoritesView()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            BackdropCraouselView(movies: vm.trending)
                            PosterCarousselView(title: "Movie of the day", movies: vm.nowPlaying)
                            PosterCarousselView(title: "Recently added", movies: vm.upcoming)
                            PosterCarousselView(title: "Top Rated Movie", movies: vm.topRated)
                        }
                        .padding([.top, .bottom])
                    }
                }
            }
            .navigationTitle("Welcome")
            .task {
                if !vm.hasAppeared {
                    await vm.populateMovies()
                    vm.hasAppeared = true
                }
            }
            .overlay() {
                if vm.isLoading {
                    ProgressView()
                }
            }
//            .alert("Application Error", isPresented: $vm.showAlert) {
//                Button("OK") { }
//            } message: {
//                if let errorMessage = vm.errorMessage {
//                    Text(errorMessage)
//                }
//            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task {
                            await vm.populateMovies()
                        }
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.orange)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "gear")
                        .foregroundColor(.orange)
                }
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
