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
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    MediaBackdropCarouselView(content: vm.nowPlaying)
                        .padding(.bottom, 10)
                    MediaPosterCarouselView(title: "Movie of the day", content: vm.nowPlaying)
                    MediaPosterCarouselView(title: "Recently Added", content: vm.upcoming)
                    MediaPosterCarouselView(title: "Top Rated Movie", content: vm.topRated)
                }
            }
            .navigationTitle("Welcome")
            .task {
                if !vm.hasAppeared {
                    await vm.populateMovies()
                    vm.hasAppeared = true
                }
            }
            .refreshable {
                Task {
                    await vm.populateMovies()
                }
            }
            .overlay {
                if vm.isLoading {
                    ProgressView()
                }
            }
            .alert("Application Error", isPresented: $vm.hasError, presenting: vm.error) { _ in
                Button("Retry") {
                    Task {
                        await vm.populateMovies()
                    }
                }
            } message: { error in
                Text(error.errorDescription ?? "Try again later")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        Task {
                            await vm.populateMovies()
                        }
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundStyle(.orange)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: "SettingsView") {
                        Image(systemName: "gear")
                            .foregroundStyle(.orange)
                    }
                }
            }
        }
    }
}

#Preview {
    MovieListView()
}
