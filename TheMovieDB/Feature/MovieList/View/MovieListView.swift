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
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    PosterCaroussel(title: "Movie of the day", movies: vm.nowPlaying)
                    PosterCaroussel(title: "Recently added", movies: vm.upcoming)
                    PosterCaroussel(title: "Top Rated Movie", movies: vm.topRated)
                }
                .padding(.top, 60)
            }
            .task {
                if !vm.hasAppeared {
                    await populateMovies()
                    vm.hasAppeared = true
                }
            }
            .overlay() {
                if vm.isLoading {
                    ProgressView()
                }
            }
            .alert("Application Error", isPresented: $vm.showAlert) {
                Button("OK") { }
            } message: {
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task {
                            await populateMovies()
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
    
    private func populateMovies() async {
        await vm.fetchNowPlaying(from: .nowPlaying)
        await vm.fetchUpcoming(from: .upcoming)
        await vm.fetchTopRated(from: .topRated)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
